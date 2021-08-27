@isTest
global class CalloutMock implements HttpCalloutMock{
  global HttpResponse respond(HTTPRequest request){
          
      HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"example":"test"}');
        res.setStatusCode(200);
      return res;
  }
}
