#!/usr/bin/env python
# coding: utf-8

# In[6]:


# -*- coding: utf-8 -*-
import sys
import pandas as pd
import numpy as np
from sklearn.preprocessing import MinMaxScaler
import pymysql

#def get_interest_ml(param_busi_profits, param_net_incm, param_ttl_liab, param_credit_rnk):
print("number of arguments :", len(sys.argv))
print("argument list :", str(sys.argv))
# 1.
db = pymysql.connect(
    host = 'localhost',
    user = 'root',
    password = 'yellow94',
    db = 'mydb',
    charset = 'utf8'
)
cursor = db.cursor(pymysql.cursors.DictCursor)

sql = "select * from MLTBL"
cursor.execute(sql)
result = cursor.fetchall()
df = pd.DataFrame(result)

# 2.
new_data = {'BUSI_PROFITS':sys.argv[1], 'NET_INCM':sys.argv[2], 'TTL_LIAB':sys.argv[3], 'CREDIT_RNK':float(sys.argv[4])}
df2 = df.append(new_data, ignore_index=True)

df3 = df2.drop(['INTEREST', 'CREDIT_RNK'], axis=1)
scaler = MinMaxScaler(feature_range=(0,1))
df3 = scaler.fit_transform(df3)

df3 = pd.DataFrame(data=df3, columns=['BUSI_PROFITS', 'NET_INCM', 'TTL_LIAB'])

credit_rnk_col = df2['CREDIT_RNK']
interest_col = df2['INTEREST']
df3['CREDIT_RNK'] = credit_rnk_col
df3['INTEREST'] = interest_col

# 3.
interest = 1.7 * df3.tail(1).TTL_LIAB + 0.1 * df3.tail(1).CREDIT_RNK + 0.1 * df3.tail(1).BUSI_PROFITS - 1.7 * df3.tail(1).NET_INCM + 1.8907794447627233
interest = round(interest, 2)
cursor.close()

#return interest
print('ttl_liab :', df3.tail(1).TTL_LIAB)
print('credit_rnk :', df3.tail(1).CREDIT_RNK)
print('busi_profits :', df3.tail(1).BUSI_PROFITS)
print('net_incm :', df3.tail(1).NET_INCM)
print(interest)
