USE [master]
GO

/****** Object:  Database [CartoesTC]    Script Date: 22/07/2025 11:34:25 ******/
CREATE DATABASE [CartoesTC]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CartoesBCLI', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\CartoesBCLI.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CartoesBCLI_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.SQLEXPRESS\MSSQL\DATA\CartoesBCLI_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO

ALTER DATABASE [CartoesTC] SET COMPATIBILITY_LEVEL = 140
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CartoesTC].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [CartoesTC] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [CartoesTC] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [CartoesTC] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [CartoesTC] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [CartoesTC] SET ARITHABORT OFF 
GO

ALTER DATABASE [CartoesTC] SET AUTO_CLOSE ON 
GO

ALTER DATABASE [CartoesTC] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [CartoesTC] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [CartoesTC] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [CartoesTC] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [CartoesTC] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [CartoesTC] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [CartoesTC] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [CartoesTC] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [CartoesTC] SET  ENABLE_BROKER 
GO

ALTER DATABASE [CartoesTC] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [CartoesTC] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [CartoesTC] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [CartoesTC] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [CartoesTC] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [CartoesTC] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [CartoesTC] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [CartoesTC] SET RECOVERY SIMPLE 
GO

ALTER DATABASE [CartoesTC] SET  MULTI_USER 
GO

ALTER DATABASE [CartoesTC] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [CartoesTC] SET DB_CHAINING OFF 
GO

ALTER DATABASE [CartoesTC] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [CartoesTC] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [CartoesTC] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [CartoesTC] SET QUERY_STORE = OFF
GO

ALTER DATABASE [CartoesTC] SET  READ_WRITE 
GO


