use FMCG_FIN_OLTP


SELECT
    Symbol,
    Company_Name,
    YEAR(Period)           AS year,
    LEFT(Fiscal_Quarter,2) AS quarter,

    ROUND(SUM(Current_Assets), 2)          AS current_assets,
    ROUND(SUM(Non_Current_Assets), 2)      AS non_current_assets,
    ROUND(SUM(Current_Liabilities), 2)     AS current_liabilities,
    ROUND(SUM(Non_Current_Liabilities), 2) AS non_current_liabilities,
    ROUND(SUM(Net_Assets), 2)               AS net_assets
FROM FMCG_FIN_OLTP.dbo.financials_fmcg
GROUP BY
    Symbol,
    Company_Name,
    YEAR(Period),
    LEFT(Fiscal_Quarter, 2);