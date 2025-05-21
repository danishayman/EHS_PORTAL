using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FETS.Pages
{
    public partial class Dashboard : System.Web.UI.Page
    {
        // Add these properties to store the total counts
        protected int TotalActive { get; private set; }
        protected int TotalUnderService { get; private set; }
        protected int TotalExpired { get; private set; }
        protected int TotalExpiringSoon { get; private set; }
        protected int TotalFireExtinguishers { get; private set; }



        // Welcome, brave soul. If you're reading this, 
        // you have inherited my code.
        // May the odds be ever in your favor.

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadTotalStatusCounts();
                LoadPlantStatistics();
                LoadChartData();
            }
        }

        /// <summary>
        /// Loads total counts of fire extinguishers by status across all plants
        /// </summary>
        private void LoadTotalStatusCounts()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(@"
                    SELECT 
                        COUNT(fe.FEID) as TotalFE,
                        SUM(CASE WHEN s.StatusName = 'Active' THEN 1 ELSE 0 END) as TotalActive,
                        SUM(CASE WHEN s.StatusName = 'Under Service' THEN 1 ELSE 0 END) as TotalUnderService,
                        SUM(CASE WHEN s.StatusName = 'Expired' THEN 1 ELSE 0 END) as TotalExpired,
                        SUM(CASE WHEN s.StatusName = 'Expiring Soon' THEN 1 ELSE 0 END) as TotalExpiringSoon
                    FROM FETS.FireExtinguishers fe
                    JOIN FETS.Status s ON fe.StatusID = s.StatusID", conn))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            TotalFireExtinguishers = reader.IsDBNull(reader.GetOrdinal("TotalFE")) ? 0 : reader.GetInt32(reader.GetOrdinal("TotalFE"));
                            TotalActive = reader.IsDBNull(reader.GetOrdinal("TotalActive")) ? 0 : reader.GetInt32(reader.GetOrdinal("TotalActive"));
                            TotalUnderService = reader.IsDBNull(reader.GetOrdinal("TotalUnderService")) ? 0 : reader.GetInt32(reader.GetOrdinal("TotalUnderService"));
                            TotalExpired = reader.IsDBNull(reader.GetOrdinal("TotalExpired")) ? 0 : reader.GetInt32(reader.GetOrdinal("TotalExpired"));
                            TotalExpiringSoon = reader.IsDBNull(reader.GetOrdinal("TotalExpiringSoon")) ? 0 : reader.GetInt32(reader.GetOrdinal("TotalExpiringSoon"));
                        }
                    }
                }
            }
        }

        /// <summary>
        /// Loads fire extinguisher statistics for each plant into the repeater control
        /// </summary>
        private void LoadPlantStatistics()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(@"
SELECT 
    p.PlantID,
    p.PlantName,
    COUNT(fe.FEID) as TotalFE,
    SUM(CASE WHEN s.StatusName = 'Active' THEN 1 ELSE 0 END) as InUse,
    SUM(CASE WHEN s.StatusName = 'Under Service' THEN 1 ELSE 0 END) as UnderService,
    SUM(CASE WHEN s.StatusName = 'Expired' THEN 1 ELSE 0 END) as Expired,
    SUM(CASE WHEN s.StatusName = 'Expiring Soon' THEN 1 ELSE 0 END) as ExpiringSoon,
    MIN(CASE 
        WHEN s.StatusName IN ('Active', 'Expiring Soon') AND fe.DateExpired >= GETDATE()
        THEN fe.DateExpired 
        ELSE NULL 
    END) as NextExpiryDate
FROM FETS.Plants p
LEFT JOIN FETS.FireExtinguishers fe ON p.PlantID = fe.PlantID
LEFT JOIN FETS.Status s ON fe.StatusID = s.StatusID
GROUP BY p.PlantID, p.PlantName
ORDER BY p.PlantName", conn))
                {
                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        adapter.Fill(dt);

                        // Replace null values with zero to prevent rendering issues
                        foreach (DataRow row in dt.Rows)
                        {
                            if (row["TotalFE"] == DBNull.Value) row["TotalFE"] = 0;
                            if (row["InUse"] == DBNull.Value) row["InUse"] = 0;
                            if (row["UnderService"] == DBNull.Value) row["UnderService"] = 0;
                            if (row["Expired"] == DBNull.Value) row["Expired"] = 0;
                            if (row["ExpiringSoon"] == DBNull.Value) row["ExpiringSoon"] = 0;
                            if (row["NextExpiryDate"] == DBNull.Value) row["NextExpiryDate"] = DateTime.MaxValue;
                        }

                        rptPlants.DataSource = dt;
                        rptPlants.DataBind();
                    }
                }
            }
        }

        /// <summary>
        /// Loads fire extinguisher type distribution data for the dashboard chart
        /// </summary>
        private void LoadChartData()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                using (SqlCommand cmd = new SqlCommand(@"
                    SELECT fet.TypeName as Type, COUNT(fe.FEID) as Count
                    FROM FETS.FireExtinguisherTypes fet
                    LEFT JOIN FETS.FireExtinguishers fe ON fet.TypeID = fe.TypeID
                    GROUP BY fet.TypeName
                    ORDER BY fet.TypeName", conn))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        int abcCount = 0;
                        int co2Count = 0;

                        while (reader.Read())
                        {
                            string type = reader["Type"].ToString();
                            int count = Convert.ToInt32(reader["Count"]);

                            if (type == "ABC") abcCount = count;
                            else if (type == "CO2") co2Count = count;
                        }

                        // Store chart data as comma-separated values for JavaScript processing
                        hdnChartData.Value = $"{abcCount},{co2Count}";
                    }
                }
            }
        }

        /// <summary>
        /// Calculates percentage for progress bar visualization
        /// </summary>
        /// <param name="value">Current value</param>
        /// <param name="total">Total value</param>
        /// <returns>Percentage value capped at 100%</returns>
        protected string GetPercentage(object value, object total)
        {
            if (value == null || total == null) return "0";

            int val = Convert.ToInt32(value);
            int tot = Convert.ToInt32(total);

            if (tot == 0) return "0";

            return Math.Min(100, (val * 100) / tot).ToString();
        }
    }
}