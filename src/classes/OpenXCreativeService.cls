Global with sharing class OpenXCreativeService {

    public String account_id;
    public String account_uid;
    public String ad_type_full;
    public String name;
    public String uri;
    public String width;
    public String height;
    public String bitrate;
    public String orig_name;

     public OpenXCreativeService (JSONParser parser)
    {
        while (parser.nextToken() != JSONToken.END_OBJECT) 
        {
            if (parser.getCurrentToken() == JSONToken.FIELD_NAME) 
                {
                    String text = parser.getText();
                                        
                    if (parser.nextToken() != JSONToken.VALUE_NULL) 
                    {
                        if (text == 'account_id')
                        {
                            account_id=parser.getText();
                        }else if(text =='account_uid')
                        {
                             account_uid=parser.getText();
                        }else if(text =='ad_type_full')
                        {
                             ad_type_full=parser.getText();
                        }
                        else if(text =='name')
                        {
                            name=parser.getText();
                        }
                        else if(text =='uri')
                        {
                             uri=parser.getText();
                        }
                        else if(text =='width')
                        {
                             width=parser.getText();
                        }
                        else if(text =='height')
                        {
                             height=parser.getText();
                        }
                        else if(text =='bitrate')
                        {
                             bitrate=parser.getText();
                        }
                        else if(text =='orig_name')
                        {
                             orig_name=parser.getText();
                        }
                     }
                 }
             else
             {
                 //TODO : incase a value null
             }
       }
  }   
    //Get Creative Data List from OpenX
      webService static OpenXCreativeService GetcreativeList(String accessApikey) {  
                String Apiendpoint= 'http://openx_server_name/ox/4.0/creative/upload_creative'; 
                Http h = new Http();
                HttpRequest req = new HttpRequest();
                req.setMethod('GET');
                req.setHeader('openx3_access_token',accessApikey);
                req.setHeader('Content-Type', 'application/x-www-form-urlencoded');                       
                req.setEndpoint(Apiendpoint);                         
                HttpResponse res=new HttpResponse();
                res = h.send(req);              
                return new OpenXCreativeService(System.JSON.createParser(res.getbody()));
     }
     
      //Create Creative on OpenX
       webService static OpenXCreativeService CreateCreative(String accessApikey,OpenXCreativeService creative) {
                String Apiendpoint= 'http://openx_server_name/ox/4.0/creative/upload_creative';
                string jsonContent= Json.Serialize(creative);                
                Http h = new Http();
                HttpRequest req = new HttpRequest();
                req.setMethod('POST');
                req.setHeader('openx3_access_token',accessApikey);
                req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
                req.setBody('advertiser='+jsonContent);
                req.setEndpoint(Apiendpoint);                        
                HttpResponse res=new HttpResponse();
                res = h.send(req);
                return new OpenXCreativeService(System.JSON.createParser(res.getbody()));
      }
     //Update Creative on OpenX
      webService static OpenXCreativeService UpdateCreative(String accessApikey,Integer id,OpenXCreativeService creative) {
                String Apiendpoint= 'http://openx_server_name/ox/4.0/creative/upload_creative'+id;
                string jsonContent= Json.Serialize(creative); 
                Http h = new Http();
                HttpRequest req = new HttpRequest();
                req.setMethod('PUT');
                req.setHeader('openx3_access_token',accessApikey);
                req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
                req.setBody('advertiser='+jsonContent);               
                req.setEndpoint(Apiendpoint);                        
                HttpResponse res=new HttpResponse();
                res = h.send(req);
                return new OpenXCreativeService(System.JSON.createParser(res.getbody()));
     } 
    
    
    
}