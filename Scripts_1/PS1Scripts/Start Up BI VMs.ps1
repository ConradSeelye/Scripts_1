

Select-AzureSubscription -SubscriptionName "Pay-As-You-Go"

Start-AzureVM -Name "BIDevSQLb" -ServiceName "BIPDevSQLb" 

Start-AzureVM -Name "BIDevSQLd" -ServiceName "ygsbi" 
Start-AzureVM -Name "BIDevSQLe" -ServiceName "ygsbi" 

Start-AzureVM -Name "ygsdwdev" -ServiceName "ygsdwdev" 

Start-AzureVM -Name "ygsdwdev4" -ServiceName "ygsdwdev4" 


Select-AzureSubscription -SubscriptionName "Seattle YMCA Main Subscription"

Start-AzureVM -Name "YGSDWProd4" -ServiceName "YGSDWProd4"

