-- 1. What are the top 5 brands by receipts scanned for most recent month?

SELECT b.name, COUNT(r._id) AS ReceiptsCount
FROM Receipts r
JOIN Transaction t ON r._id = t.receiptId
JOIN TransactionItems ti ON t.transactionId = ti.transactionId
JOIN Items i ON ti.itemId = i.itemId
JOIN Brand b ON i.brandId = b._id
WHERE MONTH(r.dateScanned) = MONTH(CURRENT_DATE - INTERVAL 1 MONTH)
AND YEAR(r.dateScanned) = YEAR(CURRENT_DATE - INTERVAL 1 MONTH)
GROUP BY b.name
ORDER BY ReceiptsCount DESC
LIMIT 5;

-- 2. How does the ranking of the top 5 brands by receipts scanned for the recent month compare to the ranking for the previous month?

WITH RecentMonthRanking AS (
  SELECT b._id, b.name, COUNT(r._id) AS ReceiptsCount,
         RANK() OVER (ORDER BY COUNT(r._id) DESC) AS Rank
  FROM Receipts r
  JOIN Transaction t ON r._id = t.receiptId
  JOIN TransactionItems ti ON t.transactionId = ti.transactionId
  JOIN Items i ON ti.itemId = i.itemId
  JOIN Brand b ON i.brandId = b._id
  WHERE MONTH(r.dateScanned) = MONTH(CURRENT_DATE - INTERVAL 1 MONTH)
    AND YEAR(r.dateScanned) = YEAR(CURRENT_DATE - INTERVAL 1 MONTH)
  GROUP BY b._id, b.name
),
PreviousMonthRanking AS (
  SELECT b._id, b.name, COUNT(r._id) AS ReceiptsCount,
         RANK() OVER (ORDER BY COUNT(r._id) DESC) AS Rank
  FROM Receipts r
  JOIN Transaction t ON r._id = t.receiptId
  JOIN TransactionItems ti ON t.transactionId = ti.transactionId
  JOIN Items i ON ti.itemId = i.itemId
  JOIN Brand b ON i.brandId = b._id
  WHERE MONTH(r.dateScanned) = MONTH(CURRENT_DATE - INTERVAL 2 MONTH)
    AND YEAR(r.dateScanned) = YEAR(CURRENT_DATE - INTERVAL 2 MONTH)
  GROUP BY b._id, b.name
)
SELECT RMR.name, RMR.Rank AS RecentMonthRank, PMR.Rank AS PreviousMonthRank
FROM RecentMonthRanking RMR
JOIN PreviousMonthRanking PMR ON RMR._id = PMR._id
ORDER BY RMR.Rank, PMR.Rank;

-- 3. When considering average spend from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?

SELECT
  CASE
    WHEN AVG(CASE WHEN rewardsReceiptStatus = 'Accepted' THEN totalSpent END) > AVG(CASE WHEN rewardsReceiptStatus = 'Rejected' THEN totalSpent END)
    THEN 'Accepted has a higher average spend'
    WHEN AVG(CASE WHEN rewardsReceiptStatus = 'Accepted' THEN totalSpent END) < AVG(CASE WHEN rewardsReceiptStatus = 'Rejected' THEN totalSpent END)
    THEN 'Rejected has a higher average spend'
    ELSE 'Accepted and Rejected have the same average spend'
  END AS ComparisonResult
FROM Receipts
WHERE rewardsReceiptStatus IN ('Accepted', 'Rejected');

-- 4. When considering total number of items purchased from receipts with 'rewardsReceiptStatus’ of ‘Accepted’ or ‘Rejected’, which is greater?

SELECT
  CASE
    WHEN SUM(CASE WHEN rewardsReceiptStatus = 'Accepted' THEN purchasedItemCount ELSE 0 END) > SUM(CASE WHEN rewardsReceiptStatus = 'Rejected' THEN purchasedItemCount ELSE 0 END)
    THEN 'Accepted receipts have a greater total number of items purchased'
    WHEN SUM(CASE WHEN rewardsReceiptStatus = 'Accepted' THEN purchasedItemCount ELSE 0 END) < SUM(CASE WHEN rewardsReceiptStatus = 'Rejected' THEN purchasedItemCount ELSE 0 END)
    THEN 'Rejected receipts have a greater total number of items purchased'
    ELSE 'Accepted and Rejected receipts have the same total number of items purchased'
  END AS ComparisonResult
FROM Receipts
WHERE rewardsReceiptStatus IN ('Accepted', 'Rejected');

-- 5. Which brand has the most spend among users who were created within the past 6 months?

SELECT b.name, SUM(r.totalSpent) AS TotalSpend
FROM Users u
JOIN Receipts r ON u._id = r.userId
JOIN Transaction t ON r._id = t.receiptId
JOIN TransactionItems ti ON t.transactionId = ti.transactionId
JOIN Items i ON ti.itemId = i.itemId
JOIN Brand b ON i.brandId = b._id
WHERE u.createdDate >= DATE_SUB(CURRENT_DATE, INTERVAL 6 MONTH)
GROUP BY b.name
ORDER BY TotalSpend DESC
LIMIT 1;

-- 6. Which brand has the most transactions among users who were created within the past 6 months?

SELECT b.name, COUNT(DISTINCT t.transactionId) AS TransactionCount
FROM Users u
JOIN Transaction t ON u._id = t.userId
JOIN TransactionItems ti ON t.transactionId = ti.transactionId
JOIN Items i ON ti.itemId = i.itemId
JOIN Brand b ON i.brandId = b._id
WHERE u.createdDate >= DATE_SUB(CURRENT_DATE, INTERVAL 6 MONTH)
GROUP BY b.name
ORDER BY TransactionCount DESC
LIMIT 1;
