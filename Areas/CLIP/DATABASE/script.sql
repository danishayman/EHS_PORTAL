USE [master]
GO
/****** Object:  Database [ESH]    Script Date: 22/05/2025 10:13:51 ******/
CREATE DATABASE [ESH]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ESH', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\ESH.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ESH_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\ESH_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [ESH] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ESH].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ESH] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ESH] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ESH] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ESH] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ESH] SET ARITHABORT OFF 
GO
ALTER DATABASE [ESH] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ESH] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ESH] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ESH] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ESH] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ESH] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ESH] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ESH] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ESH] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ESH] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ESH] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ESH] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ESH] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ESH] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ESH] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ESH] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ESH] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ESH] SET RECOVERY FULL 
GO
ALTER DATABASE [ESH] SET  MULTI_USER 
GO
ALTER DATABASE [ESH] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ESH] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ESH] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ESH] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ESH] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ESH] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'ESH', N'ON'
GO
ALTER DATABASE [ESH] SET QUERY_STORE = ON
GO
ALTER DATABASE [ESH] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [ESH]
GO
/****** Object:  Schema [CLIP]    Script Date: 22/05/2025 10:13:51 ******/
CREATE SCHEMA [CLIP]
GO
/****** Object:  Schema [FETS]    Script Date: 22/05/2025 10:13:51 ******/
CREATE SCHEMA [FETS]
GO
/****** Object:  Table [CLIP].[__MigrationHistory]    Script Date: 22/05/2025 10:13:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [CLIP].[__MigrationHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ContextKey] [nvarchar](300) NOT NULL,
	[Model] [varbinary](max) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [CLIP].[ActivityTrainings]    Script Date: 22/05/2025 10:13:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [CLIP].[ActivityTrainings](
	[Id] [uniqueidentifier] NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[ActivityName] [nvarchar](max) NOT NULL,
	[ActivityDate] [datetime] NOT NULL,
	[Document] [nvarchar](max) NULL,
	[CEPPointsGained] [int] NULL,
	[CPDPointsGained] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [CLIP].[AspNetRoles]    Script Date: 22/05/2025 10:13:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [CLIP].[AspNetRoles](
	[Id] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](256) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [CLIP].[AspNetUserClaims]    Script Date: 22/05/2025 10:13:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [CLIP].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [CLIP].[AspNetUserLogins]    Script Date: 22/05/2025 10:13:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [CLIP].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [CLIP].[AspNetUserRoles]    Script Date: 22/05/2025 10:13:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [CLIP].[AspNetUserRoles](
	[UserId] [nvarchar](128) NOT NULL,
	[RoleId] [nvarchar](128) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [CLIP].[AspNetUsers]    Script Date: 22/05/2025 10:13:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [CLIP].[AspNetUsers](
	[Id] [nvarchar](128) NOT NULL,
	[Email] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEndDateUtc] [datetime] NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
	[EmpID] [nvarchar](max) NULL,
	[DOE_CPD] [int] NULL,
	[Atom_CEP] [int] NULL,
	[Dosh_CEP] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [CLIP].[CertificateOfFitness]    Script Date: 22/05/2025 10:13:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [CLIP].[CertificateOfFitness](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PlantId] [int] NOT NULL,
	[RegistrationNo] [nvarchar](100) NOT NULL,
	[ExpiryDate] [date] NOT NULL,
	[MachineName] [nvarchar](255) NOT NULL,
	[Status] [nvarchar](50) NOT NULL,
	[Remarks] [nvarchar](max) NULL,
	[DocumentPath] [nvarchar](255) NULL,
	[Location] [nvarchar](255) NULL,
	[HostInfo] [nvarchar](255) NULL,
	[Department] [nvarchar](255) NULL,
	[ResidentInfo] [nvarchar](255) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [CLIP].[CompetencyModules]    Script Date: 22/05/2025 10:13:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [CLIP].[CompetencyModules](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ModuleName] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[AnnualPointDeduction] [int] NULL,
	[CompetencyType] [nvarchar](100) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [CLIP].[Monitoring]    Script Date: 22/05/2025 10:13:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [CLIP].[Monitoring](
	[MonitoringID] [int] IDENTITY(1,1) NOT NULL,
	[MonitoringName] [nvarchar](100) NOT NULL,
	[MonitoringCategory] [nvarchar](100) NULL,
	[MonitoringFreq] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [CLIP].[PlantMonitoring]    Script Date: 22/05/2025 10:13:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [CLIP].[PlantMonitoring](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PlantID] [int] NOT NULL,
	[MonitoringID] [int] NOT NULL,
	[Area] [nvarchar](100) NULL,
	[ExpDate] [datetime] NULL,
	[QuoteDate] [date] NULL,
	[QuoteSubmitDate] [datetime] NULL,
	[QuoteCompleteDate] [datetime] NULL,
	[QuoteUserAssign] [nvarchar](100) NULL,
	[EprDate] [datetime] NULL,
	[EprSubmitDate] [datetime] NULL,
	[EprCompleteDate] [datetime] NULL,
	[EprUserAssign] [nvarchar](100) NULL,
	[WorkDate] [datetime] NULL,
	[WorkSubmitDate] [datetime] NULL,
	[WorkCompleteDate] [datetime] NULL,
	[WorkUserAssign] [nvarchar](100) NULL,
	[Remarks] [nvarchar](max) NULL,
	[RenewDate] [date] NULL,
	[QuoteDoc] [nvarchar](max) NULL,
	[ePRDoc] [nvarchar](max) NULL,
	[WorkDoc] [nvarchar](max) NULL,
	[ProcStatus] [nvarchar](50) NULL,
	[ExpStatus] [nvarchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [CLIP].[Plants]    Script Date: 22/05/2025 10:13:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [CLIP].[Plants](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[PlantName] [nvarchar](100) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [CLIP].[UserCompetencies]    Script Date: 22/05/2025 10:13:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [CLIP].[UserCompetencies](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[CompetencyModuleId] [int] NOT NULL,
	[Status] [nvarchar](50) NOT NULL,
	[CompletionDate] [date] NULL,
	[ExpiryDate] [date] NULL,
	[Remarks] [nvarchar](max) NULL,
	[Building] [nvarchar](100) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [CLIP].[UserPlants]    Script Date: 22/05/2025 10:13:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [CLIP].[UserPlants](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[PlantId] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [FETS].[ActivityLogs]    Script Date: 22/05/2025 10:13:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [FETS].[ActivityLogs](
	[LogID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[Action] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](500) NULL,
	[EntityType] [nvarchar](50) NULL,
	[EntityID] [nvarchar](50) NULL,
	[IPAddress] [nvarchar](50) NULL,
	[Timestamp] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [FETS].[EmailRecipients]    Script Date: 22/05/2025 10:13:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [FETS].[EmailRecipients](
	[RecipientID] [int] IDENTITY(1,1) NOT NULL,
	[EmailAddress] [nvarchar](100) NOT NULL,
	[RecipientName] [nvarchar](100) NULL,
	[NotificationType] [nvarchar](50) NULL,
	[IsActive] [bit] NULL,
	[DateAdded] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [FETS].[FireExtinguishers]    Script Date: 22/05/2025 10:13:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [FETS].[FireExtinguishers](
	[FEID] [int] IDENTITY(1,1) NOT NULL,
	[SerialNumber] [nvarchar](50) NOT NULL,
	[PlantID] [int] NOT NULL,
	[LevelID] [int] NOT NULL,
	[Location] [nvarchar](200) NOT NULL,
	[TypeID] [int] NOT NULL,
	[DateExpired] [date] NOT NULL,
	[Remarks] [nvarchar](500) NULL,
	[StatusID] [int] NOT NULL,
	[StandbyStatus] [nvarchar](50) NULL,
	[ServiceRemarks] [nvarchar](max) NULL,
	[Replacement] [nvarchar](50) NULL,
	[DateSentService] [datetime] NULL,
	[AreaCode] [varchar](20) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [FETS].[FireExtinguisherTypes]    Script Date: 22/05/2025 10:13:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [FETS].[FireExtinguisherTypes](
	[TypeID] [int] IDENTITY(1,1) NOT NULL,
	[TypeName] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [FETS].[Levels]    Script Date: 22/05/2025 10:13:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [FETS].[Levels](
	[LevelID] [int] IDENTITY(1,1) NOT NULL,
	[PlantID] [int] NOT NULL,
	[LevelName] [nvarchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [FETS].[MapImages]    Script Date: 22/05/2025 10:13:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [FETS].[MapImages](
	[MapID] [int] IDENTITY(1,1) NOT NULL,
	[PlantID] [int] NOT NULL,
	[LevelID] [int] NOT NULL,
	[ImagePath] [nvarchar](500) NOT NULL,
	[UploadDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [FETS].[Plants]    Script Date: 22/05/2025 10:13:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [FETS].[Plants](
	[PlantID] [int] IDENTITY(1,1) NOT NULL,
	[PlantName] [nvarchar](100) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [FETS].[ServiceReminders]    Script Date: 22/05/2025 10:13:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [FETS].[ServiceReminders](
	[ReminderID] [int] IDENTITY(1,1) NOT NULL,
	[FEID] [int] NOT NULL,
	[ReminderDate] [datetime] NOT NULL,
	[ReminderSent] [bit] NULL,
	[DateCompleteService] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [FETS].[Status]    Script Date: 22/05/2025 10:13:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [FETS].[Status](
	[StatusID] [int] IDENTITY(1,1) NOT NULL,
	[StatusName] [nvarchar](50) NOT NULL,
	[ColorCode] [nvarchar](7) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [FETS].[Users]    Script Date: 22/05/2025 10:13:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [FETS].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) NOT NULL,
	[PasswordHash] [varbinary](256) NOT NULL,
	[Role] [nvarchar](20) NOT NULL,
	[PlantID] [int] NULL
) ON [PRIMARY]
GO
USE [master]
GO
ALTER DATABASE [ESH] SET  READ_WRITE 
GO
