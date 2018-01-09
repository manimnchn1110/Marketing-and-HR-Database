#Who are the clients with most potential value??
SELECT client.Name, client.ClientID, amount
FROM mydb.client, mydb.order
WHERE client.ClientID = Client_ClientID
order by Amount desc;

#What kinds of promotion should send to those clients with most potential value?
SELECT client.Name, client.ClientID, client.EmailAddress,service.ServiceName, promotion.PromoName
FROM mydb.client, mydb.service, mydb.promotion, mydb.order
WHERE client.ClientID = Client_ClientID
	and order.OrderID = 
    and PromoID = Promotion_PromoID
order by Amount desc;