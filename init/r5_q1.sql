CREATE DATABASE r5_q1;
USE r5_q1;
-- 社員所属
CREATE TABLE 社員所属 (
    社員コード INT PRIMARY KEY,
    社員氏名 VARCHAR(100),
    社員所属組織コード INT,
    社員所属組織名 VARCHAR(100),
    社員所属上位組織コード INT,
    社員所属上位組織名 VARCHAR(100),
    社員役職コード INT,
    社員役職名 VARCHAR(100),
    報告先社員コード INT,
    報告先社員氏名 VARCHAR(100)
);

-- 取引先
CREATE TABLE 取引先 (
    取引先コード INT PRIMARY KEY,
    取引先名 VARCHAR(100),
    取引先区分 VARCHAR(50),
    住所 VARCHAR(255)
);

-- 得意先
CREATE TABLE 得意先 (
    取引先コード INT PRIMARY KEY,
    昨年度受注金額 DECIMAL(15, 2),
    FOREIGN KEY (取引先コード) REFERENCES 取引先(取引先コード)
);

-- 仕入先
CREATE TABLE 仕入先 (
    取引先コード INT PRIMARY KEY,
    昨年度調達金額 DECIMAL(15, 2),
    FOREIGN KEY (取引先コード) REFERENCES 取引先(取引先コード)
);

-- ブランド
CREATE TABLE ブランド (
    ブランドコード INT PRIMARY KEY,
    ブランド名 VARCHAR(100)
);

-- 品目分類
CREATE TABLE 品目分類 (
    品目分類コード INT PRIMARY KEY,
    品目分類名 VARCHAR(100)
);

-- 品目
CREATE TABLE 品目 (
    メーカー型式番号 VARCHAR(100) PRIMARY KEY,
    ブランドコード INT,
    品目分類コード INT,
    FOREIGN KEY (ブランドコード) REFERENCES ブランド(ブランドコード),
    FOREIGN KEY (品目分類コード) REFERENCES 品目分類(品目分類コード)
);

-- 取扱いブランド
CREATE TABLE 取扱いブランド (
    取引先コード INT,
    ブランドコード INT,
    PRIMARY KEY (取引先コード, ブランドコード),
    FOREIGN KEY (取引先コード) REFERENCES 取引先(取引先コード),
    FOREIGN KEY (ブランドコード) REFERENCES ブランド(ブランドコード)
);

-- 試作案件
CREATE TABLE 試作案件 (
    試作案件番号 INT PRIMARY KEY,
    試作案件名 VARCHAR(100),
    取引先コード INT,
    製品用途 VARCHAR(255),
    試作案件登録年月日 DATE,
    FOREIGN KEY (取引先コード) REFERENCES 取引先(取引先コード)
);

-- 見積依頼
CREATE TABLE 見積依頼 (
    見積依頼番号 INT PRIMARY KEY,
    見積依頼年月日 DATE
);

-- モデル
CREATE TABLE モデル (
    モデル名 VARCHAR(100) PRIMARY KEY
);

-- モデル構成品目
CREATE TABLE モデル構成品目 (
    モデル名 VARCHAR(100),
    メーカー型式番号 VARCHAR(100),
    1台当たりの所要数量 INT,
    PRIMARY KEY (モデル名, メーカー型式番号),
    FOREIGN KEY (モデル名) REFERENCES モデル(モデル名),
    FOREIGN KEY (メーカー型式番号) REFERENCES 品目(メーカー型式番号)
);

-- 試作案件品目
CREATE TABLE 試作案件品目 (
    試作案件番号 INT,
    メーカー型式番号 VARCHAR(100),
    合計所要数量 INT,
    製造台数 INT,
    得意先希望納入年月日 DATE,
    設計図面番号 VARCHAR(100),
    PRIMARY KEY (試作案件番号, メーカー型式番号),
    FOREIGN KEY (試作案件番号) REFERENCES 試作案件(試作案件番号),
    FOREIGN KEY (メーカー型式番号) REFERENCES 品目(メーカー型式番号)
);

-- 見積依頼明細
CREATE TABLE 見積依頼明細 (
    見積依頼番号 INT,
    見積依頼明細番号 INT,
    メーカー型式番号 VARCHAR(100),
    必要調達数量 INT,
    希望納入年月日 DATE,
    PRIMARY KEY (見積依頼番号, 見積依頼明細番号),
    FOREIGN KEY (見積依頼番号) REFERENCES 見積依頼(見積依頼番号),
    FOREIGN KEY (メーカー型式番号) REFERENCES 品目(メーカー型式番号)
);

-- 見積回答
CREATE TABLE 見積回答 (
    見積依頼番号 INT,
    見積回答番号 INT,
    見積有効期限 DATE,
    見積回答年月日 DATE,
    PRIMARY KEY (見積依頼番号, 見積回答番号),
    FOREIGN KEY (見積依頼番号) REFERENCES 見積依頼(見積依頼番号)
);

-- 見積回答明細
CREATE TABLE 見積回答明細 (
    見積回答明細番号 INT PRIMARY KEY,
    見積依頼明細番号 INT,
    単価 DECIMAL(10, 2),
    納入可能年月日 DATE,
    FOREIGN KEY (見積依頼明細番号) REFERENCES 見積依頼明細(見積依頼明細番号)
);

-- 発注
CREATE TABLE 発注 (
    発注番号 INT PRIMARY KEY,
    発注年月日 DATE,
    発注合計金額 DECIMAL(15, 2)
);

-- 発注明細
CREATE TABLE 発注明細 (
    発注番号 INT,
    発注明細番号 INT,
    指定納入年月日 DATE,
    PRIMARY KEY (発注番号, 発注明細番号),
    FOREIGN KEY (発注番号) REFERENCES 発注(発注番号)
);

-- 入荷
CREATE TABLE 入荷 (
    入荷番号 INT PRIMARY KEY,
    入荷年月日 DATE
);

-- 入荷明細
CREATE TABLE 入荷明細 (
    入荷番号 INT,
    入荷明細番号 INT,
    発注番号 INT,
    発注明細番号 INT,
    PRIMARY KEY (入荷番号, 入荷明細番号),
    FOREIGN KEY (入荷番号) REFERENCES 入荷(入荷番号),
    FOREIGN KEY (発注番号, 発注明細番号) REFERENCES 発注明細(発注番号, 発注明細番号)
);
