USE [AES_ASSET_DB_V3];


GO
/****** Object:  StoredProcedure [dbo].[sp_ImportData_LI]    Script Date: 2016-07-27 11:30:05 AM ******/
SET ANSI_NULLS ON;


GO
SET QUOTED_IDENTIFIER ON;


GO
-- Batch submitted through debugger: SQLQuery1.sql|7|0|C:\Users\ADMINI~1.TBL\AppData\Local\Temp\2\~vsC2DD.sql
-- ============================================= 
-- Author:          Ashfaq 
-- Create date:		26th July,2016
-- Description:     To import data into   FactLeadingIndicators Table
-- ============================================= 
ALTER PROCEDURE [dbo].[sp_ImportData_LI]

AS
BEGIN
    DECLARE @C1 AS NVARCHAR (500);
    DECLARE @C2 AS NVARCHAR (500);
    DECLARE @C3 AS NVARCHAR (500);
    DECLARE @C4 AS NVARCHAR (500);
    DECLARE @C5 AS NVARCHAR (500);
    DECLARE @C6 AS NVARCHAR (500);
    DECLARE @C7 AS NVARCHAR (500);
    DECLARE @C8 AS NVARCHAR (500);
    DECLARE @C9 AS NVARCHAR (500);
    DECLARE @C10 AS NVARCHAR (500);
    DECLARE @C11 AS NVARCHAR (500);
    DECLARE @C12 AS NVARCHAR (4000);
    DECLARE @C13 AS NVARCHAR (500);
    DECLARE @C14 AS NVARCHAR (500);
    DECLARE @C15 AS NVARCHAR (500);
    DECLARE @C16 AS NVARCHAR (500);
    DECLARE @C17 AS NVARCHAR (500);
    DECLARE @C18 AS NVARCHAR (500);
    DECLARE @DateKey AS NVARCHAR (500);
    DECLARE @AllParamAreFound AS BIT = 0;
    DECLARE @DEBUG AS TINYINT = 3;
    DECLARE @IsDeleteTestResult AS BIT = 1;
    DECLARE @IsDeleteAssetIndicators AS BIT = 1;
    DECLARE @ERRORMSG AS VARCHAR (500);
    DECLARE @ERRORFOUND AS BIT = 0;
    
	--= Variable Declare for FactLeadingIndicators
    DECLARE @CategoryKey AS NVARCHAR (500);
    DECLARE @LIKey AS NVARCHAR (500);
    DECLARE @UnitKey AS NVARCHAR (500);
    DECLARE @SampleDateKey AS NVARCHAR (500);
    DECLARE @Status AS NVARCHAR (500);
    DECLARE @Value AS NVARCHAR (500);
    DECLARE @PercentOfTarget AS NVARCHAR (500);
    DECLARE @LowerDeviation AS NVARCHAR (500);
    DECLARE @UpperDeviation AS NVARCHAR (500);
    DECLARE @TargetValueCalculation AS NVARCHAR (500);
    DECLARE @MinThresholdCalculation AS NVARCHAR (500);
    DECLARE @MaxThresholdCalculation AS NVARCHAR (500);
    DECLARE @LIName AS NVARCHAR (500);
    DECLARE @CriticalityRanking AS NVARCHAR (500);
    DECLARE @Units AS NVARCHAR (500);
    DECLARE @SampleFrequency AS NVARCHAR (500);
    DECLARE @LIKeyFK AS INT;
    DECLARE @CategoryKeyFK AS INT;
    DECLARE @UnitKeyFK AS INT;
    DECLARE @PerformanceKey AS INT;
	DECLARE @PlantKey AS NVARCHAR(200);
	DECLARE @PlantKeyFK AS NVARCHAR(200);
    -- = END OF VARIABLES 


    -- = UPDATE SOME OF THE TABLE COLUMN VALUE =========
    UPDATE  STG_LI
        SET C5 = REPLACE(C5, '#DIV/0!', '');
    UPDATE  STG_LI
        SET C6 = REPLACE(C6, '#DIV/0!', '');
    UPDATE  STG_LI
        SET C7 = REPLACE(C7, '#DIV/0!', '');
    UPDATE  STG_LI
        SET C8 = REPLACE(C8, '#DIV/0!', '');
    UPDATE  STG_LI
        SET C9 = REPLACE(C9, '#DIV/0!', '');
    UPDATE  STG_LI
        SET C10 = REPLACE(C10, '#DIV/0!', '');
    UPDATE  STG_LI
        SET C11 = REPLACE(C11, '#DIV/0!', '');
    UPDATE  STG_LI
        SET C12 = REPLACE(C12, '#DIV/0!', '');
    UPDATE  STG_LI
        SET C5 = REPLACE(C5, '%', '');
    UPDATE  STG_LI
        SET C6 = REPLACE(C6, '%', '');
    UPDATE  STG_LI
        SET C6 = REPLACE(C6, ',', '');
    UPDATE  STG_LI
        SET C7 = REPLACE(C7, '%', '');
    UPDATE  STG_LI
        SET C8 = REPLACE(C8, '%', '');
    UPDATE  STG_LI
        SET C9 = REPLACE(C9, '%', '');
    UPDATE  STG_LI
        SET C10 = REPLACE(C10, '%', '');
    UPDATE  STG_LI
        SET C11 = REPLACE(C11, '%', '');
    UPDATE  STG_LI
        SET C12 = REPLACE(C12, '%', '');
  
    -- = END OF UPDATE SOME OF THE TABLE COLUMN VALUE =========


    BEGIN TRANSACTION LI;
    DECLARE LI_CURSOR CURSOR
        FOR SELECT   TOP 1550 [C1],
                              [C2],
                              [C3],
                              [C4],
                              [C5],
                              [C6],
                              [C7],
                              [C8],
                              [C9],
                              [C10],
                              [C11],
                              [C12],
                              [C13],
                              [C14],
                              [C15],
                              [C16],
                              [C17],
                              [C18],
                              PerformanceKey
            FROM     STG_LI
            ORDER BY PerformanceKey;
    OPEN LI_CURSOR;
    FETCH NEXT FROM LI_CURSOR INTO @C1, @C2, @C3, @C4, @C5, @C6, @C7, @C8, @C9, @C10, @C11, @C12, @C13, @C14, @C15, @C16, @C17, @C18, @PerformanceKey;
    WHILE @@FETCH_STATUS = 0
        BEGIN
            -- = =================================================== START COMPARING EXCEL COLUMN FOR VALUE  =============================================================
            BEGIN
                IF (@C1 IS NOT NULL
                    OR @C1 != '')
                    BEGIN
                        SET @CategoryKey = RTRIM(LTRIM(@C1));
                    END
                IF (@C2 IS NOT NULL
                    OR @C2 != '')
                    BEGIN
                        SET @LIKey = RTRIM(LTRIM(@C2));
                    END
                IF (@C3 IS NOT NULL
                    OR @C3 != '')
                    BEGIN
                        SET @UnitKey = RTRIM(LTRIM(@C3));
                    END
                IF (@C4 IS NOT NULL
                    OR @C4 != '')
                    BEGIN
                        SET @SampleDateKey = RTRIM(LTRIM(@C4));
                    END
                IF (@C5 IS NOT NULL
                    OR @C5 != '')
                    BEGIN
                        SET @Status = RTRIM(LTRIM(@C5));
                    END
                IF (@C6 IS NOT NULL
                    OR @C6 != '')
                    BEGIN
                        SET @Value = RTRIM(LTRIM(@C6));
                    END
                IF (@C7 IS NOT NULL
                    OR @C7 != '')
                    BEGIN
                        SET @PercentOfTarget = RTRIM(LTRIM(@C7));
                    END
                IF (@C8 IS NOT NULL
                    OR @C8 != '')
                    BEGIN
                        SET @LowerDeviation = RTRIM(LTRIM(@C8));
                    END
                IF (@C9 IS NOT NULL
                    OR @C9 != '')
                    BEGIN
                        SET @UpperDeviation = RTRIM(LTRIM(@C9));
                    END
                IF (@C10 IS NOT NULL
                    OR @C10 != '')
                    BEGIN
                        SET @TargetValueCalculation = RTRIM(LTRIM(@C10));
                    END
                IF (@C11 IS NOT NULL
                    OR @C11 != '')
                    BEGIN
                        SET @MinThresholdCalculation = RTRIM(LTRIM(@C11));
                    END
                IF (@C12 IS NOT NULL
                    OR @C12 != '')
                    BEGIN
                        SET @MaxThresholdCalculation = RTRIM(LTRIM(@C12));
                    END
                -- = For DimLeadingIndicator
                IF (@C2 IS NOT NULL
                    OR @C2 != '')
                    BEGIN
                        SET @LIName = RTRIM(LTRIM(@C2));
                    END
                IF (@C13 IS NOT NULL
                    OR @C13 != '')
                    BEGIN
                        SET @CriticalityRanking = RTRIM(LTRIM(@C13));
                    END
                IF (@C14 IS NOT NULL
                    OR @C14 != '')
                    BEGIN
                        SET @Units = RTRIM(LTRIM(@C14));
                    END
                IF (@C15 IS NOT NULL
                    OR @C15 != '')
                    BEGIN
                        SET @SampleFrequency = RTRIM(LTRIM(@C15));
                    END

				IF (@C16 IS NOT NULL
                    OR @C16 != '')
                    BEGIN
                        SET @PlantKey = RTRIM(LTRIM(@C16));
                    END
            --SELECT @C13, @C14, @C15, @C16 
            END
            -- = =================================================== END OF COMPARING EXCEL COLUMN FOR VALUE  =============================================================



            -- = CHECKING MANDATORY FIELDS VALUE, IF SOME OF THE FIELDS ARE MISSING BREAK THE EXECUTION
            IF (@C1 IS NOT NULL)
               AND (@C2 IS NOT NULL)
               AND (@SampleDateKey IS NOT NULL)
                BEGIN
                    SET @DateKey = (SELECT TOP 1 Date_day_key
                                    FROM   DimDate
                                    WHERE  CONVERT (DATE, Day_date_d) = CONVERT (DATE, @SampleDateKey));
                    SET @AllParamAreFound = 1;
                END
            ELSE
                BEGIN
                    SET @AllParamAreFound = 0;
                END


        
            -- = ====================== LOOPING THROUGH MAIN DATA BLOCK  ===========================================
            IF (@AllParamAreFound = 1)
                -- = ALL PARAM VALUE IS PRESENT, NOW WE CAN ADD THOSE TO DIFFERENT TABLE
                BEGIN
                    -- = ********************* SET FK TABLES ********************** 
                    BEGIN
                        IF (@DEBUG = 1)
                            SELECT 'Inserting INTO FK Table';
							
                        BEGIN
                            -- = INSERT INTO DBO.DimPerformanceCategory TABLE 
                            IF (@CategoryKey IS NOT NULL
                                AND @CategoryKey != '')
                                BEGIN
                                    IF EXISTS (SELECT TOP 1 CategoryKey
                                               FROM   DimPerformanceCategory
                                               WHERE  CategoryName = @CategoryKey)
                                        BEGIN
                                            SET @CategoryKeyFK = (SELECT TOP 1 CategoryKey
                                                                  FROM   DimPerformanceCategory
                                                                  WHERE  CategoryName = @CategoryKey);
                                        END
                                    ELSE
                                        BEGIN
                                            INSERT  INTO DimPerformanceCategory (CategoryName)
                                            VALUES                             (@CategoryKey);
                                            SET @CategoryKeyFK = Scope_identity();
                                            IF (@@ERROR <> 0)
                                                BEGIN
                                                    SET @ERRORFOUND = 1;
                                                    SET @ERRORMSG = ERROR_MESSAGE();
                                                    BREAK;
                                                END
                                        END
                                END

							-- = NOTE: 
							-- = GET PlantKey
							IF EXISTS (SELECT TOP 1 PlantKey
                                        FROM   DimPlant
                                        WHERE  PlantName = @PlantKey)
                                BEGIN
                                    -- = NO UPDATE NEEDED
                                    SET @PlantKeyFK = (SELECT TOP 1 PlantKey
														FROM   DimPlant
														WHERE  PlantName = @PlantKey);
                                END
								ELSE 
									SET @PlantKeyFK= NULL;
						

                            -- = INSERT INTO DBO.DIMUNIT TALE 
                            IF (@DEBUG = 1)
                                SELECT 'Inserting INTO DimUnit';
                            IF (@UnitKey IS NOT NULL
                                AND @UnitKey != '')
                                BEGIN
                                    IF EXISTS (SELECT TOP 1 Unitkey
                                               FROM   DimUnit
                                               WHERE  Unitname = @UnitKey)
                                        BEGIN
                                            -- = NO UPDATE NEEDED
                                            SET @UnitKeyFK = (SELECT TOP 1 Unitkey
                                                              FROM   DimUnit
                                                              WHERE  Unitname = @UnitKey);
                                        END
                                    ELSE
                                        BEGIN                                          
                                            INSERT  INTO [DimUnit] ([Unitname], [Unitid], [Plantkey])
                                            VALUES                (@UnitKey, @UnitKeyFK, @PlantKeyFK);
                                            SET @UnitKeyFK = Scope_identity();
                                            IF (@@ERROR <> 0)
                                                BEGIN
                                                    SET @ERRORFOUND = 1;
                                                    SET @ERRORMSG = ERROR_MESSAGE();
                                                    BREAK;
                                                END
                                        END
                                END


                            -- = INSERT INTO DBO.DimLeadingIndicator TALE 
                            IF (@DEBUG = 1)
                                SELECT 'Inserting INTO DimLeadingIndicator';
                            IF (@LIName IS NOT NULL
                                AND @LIName != '')
                                BEGIN
                                    IF EXISTS (SELECT TOP 1 LIKey
                                               FROM   DimLeadingIndicator
                                               WHERE  LIName = @LIName)
                                        BEGIN
                                            -- = NO UPDATE NEEDED
                                            SET @LIKeyFK = (SELECT TOP 1 LIKey
                                                            FROM   DimLeadingIndicator
                                                            WHERE  LIName = @LIName);
                                        END
                                    ELSE
                                        BEGIN
                                            INSERT  INTO DimLeadingIndicator (LIName, CriticalityRanking, Units, SampleFrequency)
                                            VALUES                          (@LIName, @CriticalityRanking, @Units, @SampleFrequency);
                                            SET @LIKeyFK = Scope_identity();
                                            IF (@@ERROR <> 0)
                                                BEGIN
                                                    SET @ERRORFOUND = 1;
                                                    SET @ERRORMSG = ERROR_MESSAGE();
                                                    BREAK;
                                                END
                                        END
                                END
                        END
                    END
                    -- = ***************** END OF SET FK TABLES ************************ 



					-- = ***************** INSERTING INTO [FactLeadingIndicators] ************************ 

                    IF @IsDeleteTestResult = 1
                        BEGIN
                            IF EXISTS (SELECT 1
                                       FROM   FactLeadingIndicators
                                       WHERE  SampleDateKey = @DateKey)
                                BEGIN
                                    DELETE FactLeadingIndicators
                                    WHERE  SampleDateKey = @DateKey;
                                END
                            SET @IsDeleteTestResult = 0;
                        END
                    
					
					IF (@C5 IS NULL OR  @C5= '' OR @C5='0') SET @Status = NULL;
					IF (@C6 IS NULL OR  @C6= '' OR @C6='0') SET @Value = NULL;
					IF (@C7 IS NULL OR  @C7= '' OR @C7='0') SET @PercentOfTarget= NULL;
					IF (@C8 IS NULL OR  @C8 ='' OR @C8='0') SET @LowerDeviation = NULL;
					IF (@C9 IS NULL OR  @C9= '' OR @C9='0') SET @UpperDeviation = NULL;
					IF (@C10 IS NULL OR  @C10= '' OR @C10='0') SET @TargetValueCalculation = NULL;
					IF (@C11 IS NULL OR  @C11= '' OR @C11='0') SET @MinThresholdCalculation = NULL;
					IF (@C12 IS NULL OR  @C12= '' OR @C12='0') SET @MaxThresholdCalculation = NULL;
                       
                    BEGIN TRY
                        INSERT  INTO [dbo].[FactLeadingIndicators] ([CategoryKey], [LIKey], [UnitKey], [SampleDateKey], [Status], [Value], [PercentOfTarget], [LowerDeviation], [UpperDeviation], [TargetValueCalculation], [MinThresholdCalculation], [MaxThresholdCalculation])
                        VALUES                                    (@CategoryKeyFK, @LIKeyFK, @UnitKeyFK, @DateKey, @Status, @Value, @PercentOfTarget, @LowerDeviation, @UpperDeviation, @TargetValueCalculation, @MinThresholdCalculation, @MaxThresholdCalculation);
                    END TRY
                    BEGIN CATCH
                        SET @ERRORFOUND = 1;
                        SET @ERRORMSG = 'Error in [[FactLeadingIndicators]] INSERT: ' + ERROR_MESSAGE();
                        IF (@DEBUG = 3)
                            BEGIN
                                SELECT @PerformanceKey AS '@PerformanceKey',
                                       @CategoryKey AS '@CategoryKey',
                                       @LIKey AS '@LIKey',
                                       @LIKeyFK AS '@LIKeyFK',
                                       @LIName AS '@LIName',
                                       @UnitKey AS '@UnitKey',
                                       @SampleDateKey AS '@SampleDateKey',
                                       @DateKey AS '@DateKey',
                                       @Status AS '@Status',
                                       @Value AS '@Value',
                                       @PercentOfTarget AS '@PercentOfTarget',
                                       @LowerDeviation AS '@LowerDeviation',
                                       @UpperDeviation AS '@UpperDeviation',
                                       @TargetValueCalculation AS '@TargetValueCalculation',
                                       @MinThresholdCalculation AS '@MinThresholdCalculation',
                                       @MaxThresholdCalculation AS '@MaxThresholdCalculation',
                                       @LIName AS '@LIName',
                                       @CriticalityRanking AS '@CriticalityRanking',
                                       @Units AS '@Units',
                                       @SampleFrequency AS '@SampleFrequency';
                            END
                        BREAK;
                    END CATCH
                	-- = ***************** END OF INSERTING INTO [FactLeadingIndicators] ************************ 
                END


            IF (@C1 IS NULL
                OR @C1 = '')
                BREAK;
            -- = GET THE NEXT ROW.   
            FETCH NEXT FROM LI_CURSOR INTO @C1, @C2, @C3, @C4, @C5, @C6, @C7, @C8, @C9, @C10, @C11, @C12, @C13, @C14, @C15, @C16, @C17, @C18, @PerformanceKey;
        END
    CLOSE LI_CURSOR;
    DEALLOCATE LI_CURSOR;



    -- = LOG THE ERROR AND ROLLBACK THE TRANSACTION, IF NO ERROR COMMIT TRANSCATION
    IF ((@ERRORFOUND = 1)
        OR (@@ERROR <> 0))
        BEGIN
            -- IF (@DEBUG=3) SELECT 'Error Block'								
            RAISERROR (@ERRORMSG, 16, 1);
            ROLLBACK TRANSACTION LI;
			--SELECT @AssetNameValue +':'+ @DateKey AS [Title], @ERRORMSG AS [Message]
        END
    ELSE
        BEGIN
            COMMIT TRANSACTION LI;
			--SELECT 'NoError' AS [Title], 'NoError' AS [Message]
        END
END