public class SyncBadgesExternalIds {
    
	public static void syncBadges(String reportId) {
        //My Report Id - 00O6g000006jbObEAI
        String endPoint = 'callout:Salesforce_Internal_API/services/data/v52.0/analytics/reports/'+ reportId;
        //Named Credential - Salesforce_Internal_API
        Http http = new Http();
        HTTPResponse response;
        HttpRequest request = new HttpRequest();
        request.setMethod('GET');
        request.setEndpoint(endPoint);
        response = http.send(request); 
        if(response.getStatusCode()==200){
            updateBadges(response.getBody());
        } else {
            system.debug('Status:'+response.getStatusCode()+' Reason:'+response.getStatus());
        }
    }
    
    public static void updateBadges(String response){
        ReportWrapper rw = ReportWrapper.parse(response);
        List<ReportWrapper.Rows> rows = rw.FactMap.TiT.rows;
        List<trailheadapp__Badge__c> badgeList = new List<trailheadapp__Badge__c>();
        Map<String,String> labelMap = new Map<String,String>();
        for(ReportWrapper.Rows row : rows){
            List<ReportWrapper.DataCells> dataCells = row.dataCells;
            labelMap.put(dataCells[0].label,dataCells[1].label);
        }
        for(trailheadapp__Badge__c badge: [SELECT Id,Name,Learning_Content_Id__c FROM trailheadapp__Badge__c]){
            if(labelMap.containsKey(badge.Name)){
                badge.Learning_Content_Id__c = labelMap.get(badge.Name);
                badgeList.add(badge);
            }
        }
        update badgeList;
    }
}