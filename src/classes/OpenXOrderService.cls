Global with sharing class OpenXOrderService {

    public String account_uid;
    public String name;
    public String status;
    public String start_date;
    public String view_through_window;
    public String click_through_window;
     public OpenXOrderService (JSONParser parser)
    {
        while (parser.nextToken() != JSONToken.END_OBJECT) 
        {
            if (parser.getCurrentToken() == JSONToken.FIELD_NAME) 
                {
                    String text = parser.getText();                                        
                    if (parser.nextToken() != JSONToken.VALUE_NULL) 
                    {
                        if (text == 'account_uid')
                        {
                            account_uid=parser.getText();
                        }else if(text =='name')
                        {
                             name=parser.getText();
                        }else if(text =='status')
                        {
                             status=parser.getText();
                        }
                        else if(text =='start_date')
                        {
                            start_date=parser.getText();
                        }
                        else if(text =='view_through_window')
                        {
                             view_through_window=parser.getText();
                        }
                        else if(text =='click_through_window')
                        {
                             click_through_window=parser.getText();
                        }                        
                     }
                 }
             else
             {
                 //TODO : incase a value null
             }
       }
  }   
        //Get Order Data List from OpenX
          webService static OpenXOrderService GetOrderList(String accessApikey) {  
                    String Apiendpoint= 'http://openx_server_name/ox/4.0/order'; 
                    Http h = new Http();
                    HttpRequest req = new HttpRequest();
                    req.setMethod('GET');
                    req.setHeader('openx3_access_token',accessApikey);
                    req.setHeader('Content-Type', 'application/x-www-form-urlencoded');                       
                    req.setEndpoint(Apiendpoint);                         
                    HttpResponse res=new HttpResponse();
                    res = h.send(req);              
                    return new OpenXOrderService(System.JSON.createParser(res.getbody()));
         }
    
      //Create Order on OpenX
       webService static OpenXOrderService CreateOrder(String accessApikey,OpenXOrderService order) {
                String Apiendpoint= 'http://openx_server_name/ox/4.0/order';
                string jsonContent= Json.Serialize(order);                
                Http h = new Http();
                HttpRequest req = new HttpRequest();
                req.setMethod('POST');
                req.setHeader('openx3_access_token',accessApikey);
                req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
                req.setBody('advertiser='+jsonContent);
                req.setEndpoint(Apiendpoint);                        
                HttpResponse res=new HttpResponse();
                res = h.send(req);
                return new OpenXOrderService(System.JSON.createParser(res.getbody()));
      }
     //Update Order on OpenX
      webService static OpenXOrderService UpdateOrder(String accessApikey,Integer id,OpenXOrderService order) {
                String Apiendpoint= 'http://openx_server_name/ox/4.0/order'+id;
                string jsonContent= Json.Serialize(order); 
                Http h = new Http();
                HttpRequest req = new HttpRequest();
                req.setMethod('PUT');
                req.setHeader('openx3_access_token',accessApikey);
                req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
                req.setBody('advertiser='+jsonContent);               
                req.setEndpoint(Apiendpoint);                        
                HttpResponse res=new HttpResponse();
                res = h.send(req);
                return new OpenXOrderService(System.JSON.createParser(res.getbody()));
     } 
    
   
}