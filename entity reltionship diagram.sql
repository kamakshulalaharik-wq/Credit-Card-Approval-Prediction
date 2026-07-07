CREATE DATABASE CreditCardApprovalDB;
USE CreditCardApprovalDB;
CREATE TABLE Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Password VARCHAR(100) NOT NULL,
    Role VARCHAR(30) NOT NULL
);
CREATE TABLE Applicant_Details (
    ApplicantID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT,
    IncomeType VARCHAR(50),
    EducationType VARCHAR(50),
    FamilyStatus VARCHAR(50),
    HousingType VARCHAR(50),
    EmploymentDays INT,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
CREATE TABLE Credit_History (
    HistoryID INT AUTO_INCREMENT PRIMARY KEY,
    ApplicantID INT,
    MonthsBalance INT,
    PaymentStatus VARCHAR(30),
    OverdueStatus VARCHAR(30),
    FOREIGN KEY (ApplicantID) REFERENCES Applicant_Details(ApplicantID)
);
CREATE TABLE ML_Model (
    ModelID INT AUTO_INCREMENT PRIMARY KEY,
    ModelName VARCHAR(100),
    AlgorithmType VARCHAR(100),
    Accuracy DECIMAL(5,2),
    ModelFile VARCHAR(255)
);
CREATE TABLE Approval_Prediction (
    PredictionID INT AUTO_INCREMENT PRIMARY KEY,
    ApplicantID INT,
    HistoryID INT,
    ModelID INT,
    PredictionResult VARCHAR(20),
    PredictionDate DATE,
    FOREIGN KEY (ApplicantID) REFERENCES Applicant_Details(ApplicantID),
    FOREIGN KEY (HistoryID) REFERENCES Credit_History(HistoryID),
    FOREIGN KEY (ModelID) REFERENCES ML_Model(ModelID)
);
INSERT INTO Applicant_Details
(UserID, IncomeType, EducationType, FamilyStatus, HousingType, EmploymentDays)
VALUES
(1,'Working','Graduate','Married','Owned',1800),
(2,'Business','Post Graduate','Single','Rented',1200);
INSERT INTO Credit_History
(ApplicantID, MonthsBalance, PaymentStatus, OverdueStatus)
VALUES
(1,24,'Paid On Time','No'),
(2,18,'Late Payment','Yes');
INSERT INTO ML_Model
(ModelName, AlgorithmType, Accuracy, ModelFile)
VALUES
('Credit Approval Model','Random Forest',95.60,'credit_model.pkl');
INSERT INTO Approval_Prediction
(ApplicantID, HistoryID, ModelID, PredictionResult, PredictionDate)
VALUES
(1,1,1,'Approved','2026-07-07'),
(2,2,1,'Rejected','2026-07-07');
SELECT * FROM Users;