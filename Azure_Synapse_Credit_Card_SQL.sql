SELECT TOP (10000) [ID]
,[Credit_Limit]
,[Gender]
,[Education_Level]
,[Marital_Status]
,[Age]
,[PAY_0]
,[PAY_2]
,[PAY_3]
,[PAY_4]
,[PAY_5]
,[PAY_6]
,[BILL_AMT1]
,[BILL_AMT2]
,[BILL_AMT3]
,[BILL_AMT4]
,[BILL_AMT5]
,[BILL_AMT6]
,[PAY_AMT1]
,[PAY_AMT2]
,[PAY_AMT3]
,[PAY_AMT4]
,[PAY_AMT5]
,[PAY_AMT6]
,[Default_Status]
,[TOTAL_BILL]
,[TOTAL_PAY]
,[PAY_RATIO]
 FROM [Synapse_analytics_credit_Card_de].[dbo].[synapse_credit_Card]



SELECT 
    [Education_Level],
    AVG([TOTAL_BILL]) AS Avg_Total_Bill,
    AVG([TOTAL_PAY]) AS Avg_Total_Payment,
    AVG([PAY_RATIO]) AS Avg_Pay_Ratio
FROM [Synapse_analytics_credit_Card_de].[dbo].[synapse_credit_Card]
GROUP BY [Education_Level]
ORDER BY Avg_Pay_Ratio DESC;

--Average Total Bill and Payment by Education Level--
SELECT 
    [Education_Level],
    COUNT(*) AS Total_Customers,
    SUM(CASE WHEN [Default_Status] = 1 THEN 1 ELSE 0 END) AS Defaults,
    ROUND(100.0 * SUM(CASE WHEN [Default_Status] = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS Default_Rate_Percent
FROM [Synapse_analytics_credit_Card_de].[dbo].[synapse_credit_Card]
GROUP BY [Education_Level]
ORDER BY Default_Rate_Percent DESC;

--Average Payment Ratio by Age Group--
SELECT 
    CASE 
        WHEN [Age] < 30 THEN 'Under 30'
        WHEN [Age] BETWEEN 30 AND 50 THEN '30-50'
        ELSE 'Over 50'
    END AS Age_Group,
    COUNT(*) AS Total_Customers,
    AVG([PAY_RATIO]) AS Avg_Pay_Ratio
FROM [Synapse_analytics_credit_Card_de].[dbo].[synapse_credit_Card]
GROUP BY 
    CASE 
        WHEN [Age] < 30 THEN 'Under 30'
        WHEN [Age] BETWEEN 30 AND 50 THEN '30-50'
        ELSE 'Over 50'
    END
ORDER BY Avg_Pay_Ratio DESC;

--DEFAULT RATE BY MARITIAL STATUS--
-- This query calculates the default rate for each marital status group

SELECT 
    [Marital_Status],
    COUNT(*) AS Total_Customers, -- Number of customers in each marital status group
    SUM(CASE WHEN [Default_Status] = 1 THEN 1 ELSE 0 END) AS Total_Defaults, -- Count of defaults
    ROUND(100.0 * SUM(CASE WHEN [Default_Status] = 1 THEN 1 ELSE 0 END) / COUNT(*), 2) AS Default_Rate_Percent -- % of defaulters
FROM [Synapse_analytics_credit_Card_de].[dbo].[synapse_credit_Card]
GROUP BY [Marital_Status]
ORDER BY Default_Rate_Percent DESC; -- Sort by highest default rate


--Customers with Low Payment Ratios--
-- Find customers who consistently pay less than 10% of their total bill

SELECT 
    [ID],
    [TOTAL_BILL],
    [TOTAL_PAY],
    [PAY_RATIO],
    [Default_Status]
FROM [Synapse_analytics_credit_Card_de].[dbo].[synapse_credit_Card]
WHERE [PAY_RATIO] < 0.1 -- Low repayment rate
ORDER BY [PAY_RATIO] ASC;


--Average Bill and Payment by Gender--
-- Analyze average billing and repayment behavior across genders

SELECT 
    [Gender],
    AVG([TOTAL_BILL]) AS Avg_Total_Bill, -- Mean bill amount
    AVG([TOTAL_PAY]) AS Avg_Total_Payment, -- Mean repayment amount
    AVG([PAY_RATIO]) AS Avg_Pay_Ratio -- Mean repayment ratio
FROM [Synapse_analytics_credit_Card_de].[dbo].[synapse_credit_Card]
GROUP BY [Gender];


--Correlation Indicators: High Bill, Low Pay--
-- Identify customers with high bills but below-average payment ratios

SELECT 
    [ID],
    [TOTAL_BILL],
    [TOTAL_PAY],
    [PAY_RATIO]
FROM [Synapse_analytics_credit_Card_de].[dbo].[synapse_credit_Card]
WHERE [TOTAL_BILL] > (SELECT AVG([TOTAL_BILL]) FROM [Synapse_analytics_credit_Card_de].[dbo].[synapse_credit_Card])
  AND [PAY_RATIO] < (SELECT AVG([PAY_RATIO]) FROM [Synapse_analytics_credit_Card_de].[dbo].[synapse_credit_Card])
ORDER BY [PAY_RATIO];







