Global with sharing class OpenXLineItemService {

    Global class Geographic {
        public Integer value_count;
    
     public Geographic (JSONParser parser)
     {
        while (parser.nextToken() != JSONToken.END_OBJECT) 
        {
            if (parser.getCurrentToken() == JSONToken.FIELD_NAME) 
                {
                    String text = parser.getText();
                                        
                    if (parser.nextToken() != JSONToken.VALUE_NULL) 
                    {
                        if (text == 'value_count')
                        {
                            value_count=Integer.valueof(parser.getText());
                        }                       
                        
                     }
                 }
          }
      }
    }


    public String ad_delivery;
    public String delivery_medium;
    public String name;
    public String status;
    public String order_uid;
    public String start_date;
    public Targeting targeting;
    public String type_full;
    public String account_uid;

    Global class Targeting {
        public Geographic geographic;
        public Geographic content;
        public String inter_dimension_operator;
        
     public Targeting (JSONParser parser)
     {
        while (parser.nextToken() != JSONToken.END_OBJECT) 
        {
            if (parser.getCurrentToken() == JSONToken.FIELD_NAME) 
                {
                    String text = parser.getText();
                                        
                    if (parser.nextToken() != JSONToken.VALUE_NULL) 
                    {
                        if (text == 'geographic')
                        {
                         Geographic = new Geographic(parser);
                         
                        }
                        else if (text == 'content')
                        {
                         Geographic = new Geographic(parser);
                         
                        }
                        else if (text == 'inter_dimension_operator')
                        {
                         inter_dimension_operator = parser.getText();
                         
                        }
                       
                     }
                 }
          }
      }
        
    }
   public OpenXLineItemService(JSONParser parser)
     {
        while (parser.nextToken() != JSONToken.END_OBJECT) 
        {
            if (parser.getCurrentToken() == JSONToken.FIELD_NAME) 
                {
                    String text = parser.getText();
                                        
                    if (parser.nextToken() != JSONToken.VALUE_NULL) 
                    {
                        if (text == 'ad_delivery')
                        {
                         ad_delivery = parser.getText();
                         
                        }
                        else if (text == 'delivery_medium')
                        {
                         delivery_medium =parser.getText();
                         
                        }
                        else if (text == 'name')
                        {
                            name=parser.getText();
                        } 
                        else if (text == 'status')
                        {
                            status=parser.getText();
                        }  
                        else if (text == 'order_uid')
                        {
                            order_uid=parser.getText();
                        }                        
                         else if (text == 'start_date')
                        {
                           start_date=parser.getText();
                        }  
                        else if (text == 'targeting')
                        {
                          Targeting =new Targeting (parser);
                        }                      
                         else if (text == 'type_full')
                        {
                           type_full=parser.getText();
                        }
                        else if (text == 'account_uid')
                        {
                           account_uid=parser.getText();
                        }   
                     }
                 }
          }
      }
   //Get LineItem Data List from OpenX
          webService static OpenXLineItemService GetLineItemList(String accessApikey) {  
                    String Apiendpoint= 'http://openx_server_name/ox/4.0/lineitem'; 
                    Http h = new Http();
                    HttpRequest req = new HttpRequest();
                    req.setMethod('GET');
                    req.setHeader('openx3_access_token',accessApikey);
                    req.setHeader('Content-Type', 'application/x-www-form-urlencoded');                       
                    req.setEndpoint(Apiendpoint);                         
                    HttpResponse res=new HttpResponse();
                    res = h.send(req);              
                    return new OpenXLineItemService(System.JSON.createParser(res.getbody()));
         }
    
      //Create LineItem on OpenX
       webService static OpenXLineItemService CreateLineItem(String accessApikey,OpenXLineItemService lineitem) {
                String Apiendpoint= 'http://openx_server_name/ox/4.0/lineitem';
                string jsonContent= Json.Serialize(lineitem);                
                Http h = new Http();
                HttpRequest req = new HttpRequest();
                req.setMethod('POST');
                req.setHeader('openx3_access_token',accessApikey);
                req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
                req.setBody('advertiser='+jsonContent);
                req.setEndpoint(Apiendpoint);                        
                HttpResponse res=new HttpResponse();
                res = h.send(req);
                return new OpenXLineItemService(System.JSON.createParser(res.getbody()));
      }
     //Update LineItem on OpenX
      webService static OpenXLineItemService UpdateLineItem(String accessApikey,Integer id,OpenXLineItemService lineitem) {
                String Apiendpoint= 'http://openx_server_name/ox/4.0/lineitem'+id;
                string jsonContent= Json.Serialize(lineitem); 
                Http h = new Http();
                HttpRequest req = new HttpRequest();
                req.setMethod('PUT');
                req.setHeader('openx3_access_token',accessApikey);
                req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
                req.setBody('advertiser='+jsonContent);               
                req.setEndpoint(Apiendpoint);                        
                HttpResponse res=new HttpResponse();
                res = h.send(req);
                return new OpenXLineItemService(System.JSON.createParser(res.getbody()));
     } 
    
    
}