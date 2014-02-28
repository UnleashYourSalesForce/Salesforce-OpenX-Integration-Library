// request url :curl http://openx_server_name/ox/4.0/adunit/available_fields?pretty=1 --cookie "openx3_access_token=token_string"
// documents : http://docs.openx.com/api/#api_create_adunit_use_case.html
//
Global with sharing class OpenXAdunitService {

    public String site_uid;
    public String name;
    public String status;
    public String delivery_medium_id;
    public String tag_type_id;
    public String content_type_id;
    public String type_full;
    public String size_id;
    
    public OpenXAdunitService (JSONParser parser)
    {
        while (parser.nextToken() != JSONToken.END_OBJECT) 
        {
            if (parser.getCurrentToken() == JSONToken.FIELD_NAME) 
                {
                    String text = parser.getText();
                                        
                    if (parser.nextToken() != JSONToken.VALUE_NULL) 
                    {
                        if (text == 'site_uid')
                        {
                            site_uid=parser.getText();
                        }else if(text =='status')
                        {
                             status=parser.getText();
                        }else if(text =='delivery_medium_id')
                        {
                             delivery_medium_id=parser.getText();
                        }
                        else if(text =='tag_type_id')
                        {
                             tag_type_id=parser.getText();
                        }
                        else if(text =='content_type_id')
                        {
                             content_type_id=parser.getText();
                        }
                        else if(text =='type_full')
                        {
                             type_full=parser.getText();
                        }
                        else if(text =='size_id')
                        {
                             size_id=parser.getText();
                        }
                     }
                 }
             else
             {
                 //TODO : incase a value null
             }
       }
  }   
    
    //Get adunit Data List from OpenX
      webService static OpenXAdunitService GetAdunitList(String accessApikey) {  
                String Apiendpoint= 'http://openx_server_name/ox/4.0/adunit'; 
                Http h = new Http();
                HttpRequest req = new HttpRequest();
                req.setMethod('GET');
                req.setHeader('openx3_access_token',accessApikey);
                req.setHeader('Content-Type', 'application/x-www-form-urlencoded');                       
                req.setEndpoint(Apiendpoint);                         
                HttpResponse res=new HttpResponse();
                res = h.send(req);              
                return new OpenXAdunitService(System.JSON.createParser(res.getbody()));
     }
     
      //Create adunit on OpenX
       webService static OpenXAdunitService CreateAdunit(String accessApikey,OpenXAdunitService adunit) {
                String Apiendpoint= 'http://openx_server_name/ox/4.0/adunit';
                string jsonContent= Json.Serialize(adunit);                
                Http h = new Http();
                HttpRequest req = new HttpRequest();
                req.setMethod('POST');
                req.setHeader('openx3_access_token',accessApikey);
                req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
                req.setBody('advertiser='+jsonContent);
                req.setEndpoint(Apiendpoint);                        
                HttpResponse res=new HttpResponse();
                res = h.send(req);
                return new OpenXAdunitService(System.JSON.createParser(res.getbody()));
      }
     //Update adunit on OpenX
      webService static OpenXAdunitService UpdateAdunit(String accessApikey,Integer id,OpenXAdunitService adunit) {
                String Apiendpoint= 'http://openx_server_name/ox/4.0/adunit'+id;
                string jsonContent= Json.Serialize(adunit); 
                Http h = new Http();
                HttpRequest req = new HttpRequest();
                req.setMethod('PUT');
                req.setHeader('openx3_access_token',accessApikey);
                req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
                req.setBody('advertiser='+jsonContent);               
                req.setEndpoint(Apiendpoint);                        
                HttpResponse res=new HttpResponse();
                res = h.send(req);
                return new OpenXAdunitService(System.JSON.createParser(res.getbody()));
     } 
    
    
}