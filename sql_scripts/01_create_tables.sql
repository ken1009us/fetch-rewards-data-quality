CREATE TABLE Receipts (
    _id UUID PRIMARY KEY,
    bonusPointsEarned INT,
    bonusPointsEarnedReason VARCHAR(255),
    createDate DATETIME,
    dateScanned DATETIME,
    finishedDate DATETIME,
    modifyDate DATETIME,
    pointsAwardedDate DATETIME,
    pointsEarned DECIMAL,
    purchaseDate DATETIME,
    purchasedItemCount INT,
    rewardsReceiptStatus VARCHAR(50),
    totalSpent DECIMAL,
    userId VARCHAR(255),
    FOREIGN KEY (userId) REFERENCES Users(_id)
);

CREATE TABLE Users (
    _id VARCHAR(255) PRIMARY KEY,
    state VARCHAR(2),
    createdDate DATETIME,
    lastLogin DATETIME,
    role VARCHAR(50),
    active BOOLEAN
);

CREATE TABLE Brand (
    _id UUID PRIMARY KEY,
    barcode VARCHAR(255),
    brandCode VARCHAR(255),
    category VARCHAR(255),
    categoryCode VARCHAR(255),
    cpg UUID,
    topBrand BOOLEAN,
    name VARCHAR(255)
);

CREATE TABLE Transaction (
    transactionId UUID PRIMARY KEY,
    userId VARCHAR(255),
    receiptId UUID,
    transactionDate DATETIME,
    totalAmount DECIMAL,
    paymentMethod VARCHAR(50),
    FOREIGN KEY (userId) REFERENCES Users(_id),
    FOREIGN KEY (receiptId) REFERENCES Receipts(_id)
);

CREATE TABLE Category (
    categoryId UUID PRIMARY KEY,
    categoryName VARCHAR(255),
);

CREATE TABLE Items (
    itemId UUID PRIMARY KEY,
    brandId UUID,
    categoryId UUID,
    itemName VARCHAR(255),
    price DECIMAL,
    barcode VARCHAR(255),
    description TEXT,
    FOREIGN KEY (brandId) REFERENCES Brands(_id),
    FOREIGN KEY (categoryId) REFERENCES Categories(categoryId)
);

CREATE TABLE TransactionItems (
    transactionId UUID,
    itemId UUID,
    quantity INT,
    itemPriceAtPurchase DECIMAL,
    PRIMARY KEY (transactionId, itemId),
    FOREIGN KEY (transactionId) REFERENCES Transactions(transactionId),
    FOREIGN KEY (itemId) REFERENCES Items(itemId)
);
