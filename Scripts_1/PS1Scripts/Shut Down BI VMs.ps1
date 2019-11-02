

Select-AzureSubscription -SubscriptionName "Pay-As-You-Go"

Stop-AzureVM -Name "ygsdwdev4" -ServiceName "ygsdwdev4" -force

Stop-AzureVM -Name "ygsdwdev" -ServiceName "ygsdwdev" -force


Select-AzureSubscription -SubscriptionName "Seattle YMCA Main Subscription"

Stop-AzureVM -Name "ygsdwprod4" -ServiceName "ygsdwprod4" -force

Stop-AzureVM -Name "william3" -ServiceName "william3" -force

Stop-AzureVM -Name "ygsdwas1" -ServiceName "ygsdwas1" -force
