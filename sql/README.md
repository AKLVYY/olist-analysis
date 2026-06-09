# SQL复现说明

本目录用于复现项目中的核心业务指标查询。SQL脚本采用 MySQL 8.0 语法，默认数据库名为 `olist`，核心分析表为 `order_base`。

## 1.准备数据

先按顺序运行 notebook，生成订单级宽表：

```text
notebooks/02_build_order_base.ipynb
```

生成后的宽表路径为：

```text
data_clean/order_base.csv
```

## 2.创建数据库和数据表

在 MySQL 中先运行：

```sql
source sql/00_create_order_base_table.sql;
```

如果使用 MySQL Workbench，也可以直接打开 `00_create_order_base_table.sql` 并执行。

## 3.导入CSV

推荐使用 MySQL Workbench 的 Table Data Import Wizard，将 `data_clean/order_base.csv` 导入 `olist.order_base`。

如果使用命令行，可以参考下面的 `LOAD DATA LOCAL INFILE` 写法。Windows 路径建议使用正斜杠：

```sql
LOAD DATA LOCAL INFILE 'D:/olist-analysis/data_clean/order_base.csv'
INTO TABLE order_base
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
```

如果本地 MySQL 禁用了 `LOCAL INFILE`，需要在客户端连接参数和 MySQL 服务端配置中启用后再执行，或者直接使用 Workbench 导入向导。

## 4.执行分析脚本

建议执行顺序如下：

```text
00_create_order_base_table.sql
01_check_order_base.sql
02_sales_overview.sql
03_monthly_sales.sql
04_state_sales.sql
05_payment_sales.sql
06_delivery_review_comparison.sql
07_delay_risk_level.sql
08_state_priority.sql
```

SQL部分主要用于展示关系型数据取数和指标复现能力；统计检验、A/B测试设计和完整业务解释仍以 notebook 与 README 为准。
