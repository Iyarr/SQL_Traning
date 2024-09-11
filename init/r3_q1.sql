CREATE DATABASE r3_q1;
USE r3_q1;
-- 店舗
CREATE TABLE 店舗 (
    加盟企業コード INT,
    店舗コード INT,
    店舗名 VARCHAR(100),
    所在地 VARCHAR(255),
    PRIMARY KEY (加盟企業コード, 店舗コード)
);

-- 会員
CREATE TABLE 会員 (
    会員コード INT PRIMARY KEY,
    会員名 VARCHAR(100),
    入会日 DATE,
    住所 VARCHAR(255),
    性別 CHAR(1),
    生年月日 DATE,
    ポイント残高 INT
);

-- 加盟企業商品
CREATE TABLE 加盟企業商品 (
    加盟企業コード INT,
    加盟企業商品コード INT,
    JANコード VARCHAR(13),
    加盟企業名 VARCHAR(100),
    契約開始日 DATE,
    契約終了日 DATE,
    加盟企業商品名 VARCHAR(100),
    横断分析用商品コード INT,
    横断分析用商品名 VARCHAR(100),
    PRIMARY KEY (加盟企業コード, 加盟企業商品コード)
);

-- 支払
CREATE TABLE 支払 (
    レシート番号 INT PRIMARY KEY,
    会員コード INT,
    支払日時 DATETIME,
    利用ポイント INT,
    FOREIGN KEY (会員コード) REFERENCES 会員(会員コード)
);

-- 支払方法明細
CREATE TABLE 支払方法明細 (
    レシート番号 INT,
    支払方法コード INT,
    付与ポイント INT,
    PRIMARY KEY (レシート番号, 支払方法コード),
    FOREIGN KEY (レシート番号) REFERENCES 支払(レシート番号)
);

-- 購入商品明細
CREATE TABLE 購入商品明細 (
    レシート番号 INT,
    加盟企業コード INT,
    加盟企業商品コード INT,
    付与ポイント INT,
    商品単価 DECIMAL(10, 2),
    PRIMARY KEY (レシート番号, 加盟企業コード, 加盟企業商品コード),
    FOREIGN KEY (レシート番号) REFERENCES 支払(レシート番号),
    FOREIGN KEY (加盟企業コード, 加盟企業商品コード) REFERENCES 加盟企業商品(加盟企業コード, 加盟企業商品コード)
);

-- 支払方法
CREATE TABLE 支払方法 (
    支払方法コード INT PRIMARY KEY,
    支払方法名 VARCHAR(100)
);

-- ポイント設定
CREATE TABLE ポイント設定 (
    ポイント設定コード INT PRIMARY KEY,
    適用開始日 DATE,
    適用終了日 DATE
);

-- クーポン設定
CREATE TABLE クーポン設定 (
    クーポンコード INT PRIMARY KEY,
    クーポン名 VARCHAR(100),
    企画加盟企業コード INT,
    配布開始日 DATE,
    配布終了日 DATE,
    利用開始日 DATE,
    利用終了日 DATE,
    ポイント付与率 DECIMAL(5, 2)
);

-- クーポン設定対象店舗
CREATE TABLE クーポン設定対象店舗 (
    クーポンコード INT,
    加盟企業コード INT,
    店舗コード INT,
    PRIMARY KEY (クーポンコード, 加盟企業コード, 店舗コード),
    FOREIGN KEY (クーポンコード) REFERENCES クーポン設定(クーポンコード),
    FOREIGN KEY (加盟企業コード, 店舗コード) REFERENCES 店舗(加盟企業コード, 店舗コード)
);

-- クーポン設定対象商品
CREATE TABLE クーポン設定対象商品 (
    クーポンコード INT,
    加盟企業コード INT,
    加盟企業商品コード INT,
    PRIMARY KEY (クーポンコード, 加盟企業コード, 加盟企業商品コード),
    FOREIGN KEY (クーポンコード) REFERENCES クーポン設定(クーポンコード),
    FOREIGN KEY (加盟企業コード, 加盟企業商品コード) REFERENCES 加盟企業商品(加盟企業コード, 加盟企業商品コード)
);
