CREATE DATABASE r4_q1;
USE r4_q1;
-- CC 要員
CREATE TABLE CC要員 (
    社員番号 INT PRIMARY KEY,
    社員氏名 VARCHAR(100) NOT NULL
);

-- BP
CREATE TABLE BP (
    BPコード INT PRIMARY KEY,
    BP名 VARCHAR(100) NOT NULL,
    所在地 VARCHAR(255),
    SLPフラグ BOOLEAN,
    ASPフラグ BOOLEAN
);

-- SLP
CREATE TABLE SLP (
    BPコード INT,
    業種 VARCHAR(100),
    前年販売高 DECIMAL(15, 2),
    PRIMARY KEY (BPコード),
    FOREIGN KEY (BPコード) REFERENCES BP(BPコード)
);

-- ASP
CREATE TABLE ASP (
    BPコード INT,
    CE数 INT,
    PRIMARY KEY (BPコード),
    FOREIGN KEY (BPコード) REFERENCES BP(BPコード)
);

-- CE
CREATE TABLE CE (
    BPコード INT,
    CE番号 INT,
    CE氏名 VARCHAR(100),
    PRIMARY KEY (BPコード, CE番号),
    FOREIGN KEY (BPコード) REFERENCES BP(BPコード)
);

-- サービス地域
CREATE TABLE サービス地域 (
    サービス地域コード INT PRIMARY KEY,
    拠点名 VARCHAR(100),
    所在地 VARCHAR(255),
    BPコード INT,
    FOREIGN KEY (BPコード) REFERENCES BP(BPコード)
);

-- EU
CREATE TABLE EU (
    EU番号 INT PRIMARY KEY,
    氏名 VARCHAR(100),
    住所 VARCHAR(255),
    サービス地域コード INT,
    電話番号 VARCHAR(15),
    更新年月日 DATE,
    FOREIGN KEY (サービス地域コード) REFERENCES サービス地域(サービス地域コード)
);

-- 製品シリーズ
CREATE TABLE 製品シリーズ (
    製品シリーズコード INT PRIMARY KEY,
    製品シリーズ名 VARCHAR(100)
);

-- 製品
CREATE TABLE 製品 (
    製品コード INT PRIMARY KEY,
    製品名 VARCHAR(100),
    製品シリーズコード INT,
    FOREIGN KEY (製品シリーズコード) REFERENCES 製品シリーズ(製品シリーズコード)
);

-- 登録製品
CREATE TABLE 登録製品 (
    製品製造番号 INT PRIMARY KEY,
    製品コード INT,
    EU番号 INT,
    更新年月日 DATE,
    FOREIGN KEY (製品コード) REFERENCES 製品(製品コード),
    FOREIGN KEY (EU番号) REFERENCES EU(EU番号)
);

-- 点検修理項目
CREATE TABLE 点検修理項目 (
    MTコード INT PRIMARY KEY,
    点検修理項目名 VARCHAR(100)
);
