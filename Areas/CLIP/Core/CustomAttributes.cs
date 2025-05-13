using System;

namespace CLIP.Core
{
    // Key identifier attribute
    [AttributeUsage(AttributeTargets.Property, AllowMultiple = false)]
    public class KeyAttribute : Attribute { }

    // Required field attribute
    [AttributeUsage(AttributeTargets.Property, AllowMultiple = false)]
    public class RequiredAttribute : Attribute { }

    // String length attribute
    [AttributeUsage(AttributeTargets.Property, AllowMultiple = false)]
    public class StringLengthAttribute : Attribute
    {
        public int MaximumLength { get; private set; }
        public int MinimumLength { get; set; }
        public string ErrorMessage { get; set; }

        public StringLengthAttribute(int maximumLength)
        {
            MaximumLength = maximumLength;
        }
    }

    // Email address attribute
    [AttributeUsage(AttributeTargets.Property, AllowMultiple = false)]
    public class EmailAddressAttribute : Attribute { }

    // Compare attribute
    [AttributeUsage(AttributeTargets.Property, AllowMultiple = false)]
    public class CompareAttribute : Attribute
    {
        public string OtherProperty { get; private set; }
        public string ErrorMessage { get; set; }

        public CompareAttribute(string otherProperty)
        {
            OtherProperty = otherProperty;
        }
    }

    // Display attribute
    [AttributeUsage(AttributeTargets.Property, AllowMultiple = false)]
    public class DisplayAttribute : Attribute
    {
        public string Name { get; set; }
    }

    // DataType attribute
    [AttributeUsage(AttributeTargets.Property, AllowMultiple = false)]
    public class DataTypeAttribute : Attribute
    {
        public DataType DataType { get; private set; }

        public DataTypeAttribute(DataType dataType)
        {
            DataType = dataType;
        }
    }

    // Display format attribute
    [AttributeUsage(AttributeTargets.Property, AllowMultiple = false)]
    public class DisplayFormatAttribute : Attribute
    {
        public string DataFormatString { get; set; }
        public bool ApplyFormatInEditMode { get; set; }
    }

    // NotMapped attribute
    [AttributeUsage(AttributeTargets.Property, AllowMultiple = false)]
    public class NotMappedAttribute : Attribute { }

    // ForeignKey attribute
    [AttributeUsage(AttributeTargets.Property, AllowMultiple = false)]
    public class ForeignKeyAttribute : Attribute
    {
        public string Name { get; private set; }

        public ForeignKeyAttribute(string name)
        {
            Name = name;
        }
    }

    // DatabaseGenerated attribute
    [AttributeUsage(AttributeTargets.Property, AllowMultiple = false)]
    public class DatabaseGeneratedAttribute : Attribute
    {
        public DatabaseGeneratedOption Option { get; private set; }

        public DatabaseGeneratedAttribute(DatabaseGeneratedOption option)
        {
            Option = option;
        }
    }

    // Enum for DataType
    public enum DataType
    {
        Date,
        Password,
        EmailAddress,
        Text
    }

    // Enum for DatabaseGeneratedOption
    public enum DatabaseGeneratedOption
    {
        None,
        Identity,
        Computed
    }
} 