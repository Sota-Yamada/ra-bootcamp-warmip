
#パッケージ読み込み
library(tidyverse)
library(openxlsx)

#データ整理と変換
#(a)Semester Dataの整形
#1.生データの読み込み
semester_dummy_1 <- read.csv("01_data/raw/semester_dummy/semester_data_1.csv")
semester_dummy_2 <- read.csv("01_data/raw/semester_dummy/semester_data_2.csv")

#2.一列目を列名に
colnames(semester_dummy_1) <- semester_dummy_1[1,]
semester_dummy_1 <- semester_dummy_1[-1,]

#3.二つのデータを適切に適合する
semester_dummy_2 <- as.character(semester_dummy_2)
semester_dummy_2 <- as.data.frame(semester_dummy_2)
semester_dummy <- dplyr::bind_rows(semester_dummy_1, semester_dummy_2)

#4.Y列の削除
semester_dummy <- semester_dummy %>% dplyr::select(-Y)

#5.semester制が導入された年の列を作成

#6.semester制導入後を示すダミー変数を作成

#(b)Gradrate Dataの整形
#1.生データを読み込み、適切に結合
gradrate_data_1991 <- read.xlsx("01_data/raw/outcome/1991.xlsx" , sheet = 1)
gradrate_data_1992 <- read.xlsx("01_data/raw/outcome/1992.xlsx" , sheet = 1)
gradrate_data_1993 <- read.xlsx("01_data/raw/outcome/1993.xlsx" , sheet = 1)
gradrate_data_1995 <- read.xlsx("01_data/raw/outcome/1995.xlsx" , sheet = 1)
gradrate_data_1996 <- read.xlsx("01_data/raw/outcome/1996.xlsx" , sheet = 1)
gradrate_data_1997 <- read.xlsx("01_data/raw/outcome/1997.xlsx" , sheet = 1)
gradrate_data_1998 <- read.xlsx("01_data/raw/outcome/1998.xlsx" , sheet = 1)
gradrate_data_1999 <- read.xlsx("01_data/raw/outcome/1999.xlsx" , sheet = 1)
gradrate_data_2000 <- read.xlsx("01_data/raw/outcome/2000.xlsx" , sheet = 1)
gradrate_data_2001 <- read.xlsx("01_data/raw/outcome/2001.xlsx" , sheet = 1)
gradrate_data_2002 <- read.xlsx("01_data/raw/outcome/2002.xlsx" , sheet = 1)
gradrate_data_2003 <- read.xlsx("01_data/raw/outcome/2003.xlsx" , sheet = 1)
gradrate_data_2004 <- read.xlsx("01_data/raw/outcome/2004.xlsx" , sheet = 1)
gradrate_data_2005 <- read.xlsx("01_data/raw/outcome/2005.xlsx" , sheet = 1)
gradrate_data_2006 <- read.xlsx("01_data/raw/outcome/2006.xlsx" , sheet = 1)
gradrate_data_2007 <- read.xlsx("01_data/raw/outcome/2007.xlsx" , sheet = 1)
gradrate_data_2008 <- read.xlsx("01_data/raw/outcome/2008.xlsx" , sheet = 1)
gradrate_data_2009 <- read.xlsx("01_data/raw/outcome/2009.xlsx" , sheet = 1)
gradrate_data_2010 <- read.xlsx("01_data/raw/outcome/2010.xlsx" , sheet = 1)
gradrate_data_2011 <- read.xlsx("01_data/raw/outcome/2011.xlsx" , sheet = 1)
gradrate_data_2012 <- read.xlsx("01_data/raw/outcome/2012.xlsx" , sheet = 1)
gradrate_data_2013 <- read.xlsx("01_data/raw/outcome/2013.xlsx" , sheet = 1)
gradrate_data_2014 <- read.xlsx("01_data/raw/outcome/2014.xlsx" , sheet = 1)
gradrate_data_2015 <- read.xlsx("01_data/raw/outcome/2015.xlsx" , sheet = 1)
gradrate_data_2016 <- read.xlsx("01_data/raw/outcome/2016.xlsx" , sheet = 1)

#2.女子学生の4年卒業率に0.01をかけて、0~1のスケールに変更
#3.男女合計の4年卒業率と男子学生の4年卒業率を計算し、新たな列として追加
#4.計算した卒業率を有効数字3桁に調整
#5.1991年から2021年までのデータフレームに変形

#(c)Covariates Dataの整形
#1.生データの読み込み
covariates <- read.xlsx("01_data/raw/covariates/covariates.xlsx", sheet = 1)

#2.university_idという列名をunitidに変更
covariates <- covariates %>% dplyr::rename(, unitid = university_id)

#3.unitidに含まれるaaaaという文字を削除
covariates <- covariates %>% str_replace_all(pattern =  "aaaa", replacement = "")

#4.category列に含まれる’instatetuition’, ‘costs’, ’faculty’, ’white_cohortsize’を別の列として追加
#5.outcomeやsemester_dummyに含まれる年を調べ、covariatesデータの期間を他のデータに揃える
#6.outcome_dataに含まれるunitidを特定し、covariatesに含まれるunitidをoutcomeデータに揃える

#(d)Master Dataの作成
#cleaning後データの読み込み
clean_covariates <- read.csv("01_data/intermediate/clean_covariates.csv")
clean_outcome <- read.csv("01_data/intermediate/clean_outcome.csv")
clean_semester <- read.csv("01_data/intermediate/clean_semester_dummy.csv")
#1.結合に用いる変数を考え、semester_data, covariates_data, gradrate_dataを適切に結合
master_data <- clean_covariates %>% 
               dplyr::left_join(., clean_outcome, by="X")%>%
               dplyr::left_join(., clean_semester, by="X")
