SELECT
    symbol,
    year,
    quarter,
    eps,
    ROUND(
        eps - LAG(eps) OVER (PARTITION BY symbol ORDER BY year, quarter),
        2
    ) AS eps_qoq_change
FROM FMCG_FIN_OLAP.dbo.FinancialPerformanceMart;








WITH LatestYear AS (
    SELECT MAX(year) AS max_year
    FROM FMCG_FIN_OLAP.dbo.FinancialPerformanceMart
)
SELECT TOP 5
    f.symbol,
    f.company_name,
    SUM(f.sales) AS total_sales
FROM FMCG_FIN_OLAP.dbo.FinancialPerformanceMart f
JOIN LatestYear y ON f.year = y.max_year
GROUP BY f.symbol, f.company_name
ORDER BY total_sales DESC;








SELECT
    symbol,
    year,
    quarter,
    sales,
    pat
FROM FMCG_FIN_OLAP.dbo.FinancialPerformanceMart
ORDER BY symbol, year, quarter;





SELECT
    symbol,
    year,
    ROUND(AVG(gp_margin), 2)*100 AS avg_gp_margin,
    ROUND(AVG(op_margin), 2)*100 AS avg_op_margin
FROM FMCG_FIN_OLAP.dbo.FinancialPerformanceMart
GROUP BY symbol, year
ORDER BY year DESC, avg_gp_margin DESC;
