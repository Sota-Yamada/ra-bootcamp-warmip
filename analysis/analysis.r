#(a) 記述統計
# 1. 「(d) Master Dataの作成」で作成したデータの、各列に含まれるNAの数を数えなさい。
master <- read.csv("01_data/intermediate/master.csv")
na_count <- master %>%
  summarise(across(everything(), ~ sum(is.na(.))))
View(na_count)

# 2. 問題背景などを知る上で役に立つ記述統計を作成しなさい


# 3. 4年卒業率の平均推移を計算し、図で示しなさい


# 4. semester導入率を計算し、図で示しなさい

# 5. 以下の3つの変数を横軸、「4年卒業率」を縦軸にとった、散布図を作成しなさい

#  女子学生比率
#  白人学生割合
#  学費(instatetuition)

# (b) 回帰分析
# 1. 以下の式を推定し、表にまとめなさい
result <- lm(gradrate4yr ~ semester, data = master)
summary(result)
