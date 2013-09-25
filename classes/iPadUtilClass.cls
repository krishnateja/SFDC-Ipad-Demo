public class iPadUtilClass{
    private static String REPORTCHART_URL1 = '/servlet/servlet.ChartServer?s=7&fs=10&tfg=12&tfs=-16777216&explode=0&cs=0&title=&eh=no&compo=yes&fg=-16777216&bg1=-1&bg2=-1&bgdir=2&dl2=&l=2&sax=yes&Yman=no&nc=0&sd=1&scv=yes&sct=no&spt=no&cu=USD&ab=X&u=0&vt=0&ab2=Y&u2=0&vt2=0&spoc=no&topn=no&gc0=-1'; 
    private static String REPORTCHART_URL2 = '/servlet/servlet.ChartServer?s=7&fs=10&tfg=12&tfs=-16777216&explode=0&cs=0&title=&eh=no&compo=no&fg=-16777216&bg1=-1&bg2=-1&bgdir=2&dl2=&l=2&sax=yes&Yman=no&nc=0&sd=1&scv=no&sct=yes&spt=no&cu=USD&ab=X&u=0&vt=0&ab2=Y&u2=0&vt2=0&spoc=no&topn=no&gm=0.0&gc0=-4041644&gm0=1.0&gc1=-4013484&gm1=2.0&gc2=-11222444&gm2=3.0'; 
    private static String REPORTCHART_URL3 = '/servlet/servlet.ChartServer?s=7&fs=10&tfg=12&tfs=-16777216&explode=0&cs=0&title=&eh=no&compo=yes&fg=-16777216&bg1=-1&bg2=-1&bgdir=2&dl2=&l=2&sax=yes&Yman=no&nc=0&sd=1&scv=no&sct=no&spt=no&cu=USD&ab=X&u=0&vt=0&ab2=Y&u2=0&vt2=0&spoc=no&topn=no&gc0=-1&gc1=-1&gc2=-1';
    private static String PAGETYPE_LOGIN = 'Login Page'; 
    private static String PAGETYPE_HOME = 'Landing Page'; 
    private static String PAGETYPE_PAGE1 = 'Page 1'; 
    private static String PAGETYPE_PAGE2 = 'Page 2';  
    private static String PAGETYPE_PAGE3 = 'Page 3'; 
    private static String PAGETYPE_PAGE4 = 'Page 4'; 
    private static String PAGETYPE_PAGE5 = 'Page 5'; 
    private static String PAGETYPE_PAGE6 = 'Page 6'; 
    private static String PAGETYPE_PAGE7 = 'Page 7'; 
    private static String PAGETYPE_PAGE8 = 'Page 8'; 

    private static String BGIMAGE_NAME1 = 'white'; 
    private static String BGIMAGE_NAME2 = 'green'; 
    private static String BGIMAGE_NAME3 = 'blue'; 
    private static String BGIMAGE_NAME4 = 'black'; 
    private static String BGIMAGE_NAMEBROWSE = 'browse';

    private static String FOLLOWUPTYPE_INTEREST = 'Interest';
    private static String FOLLOWUPTYPE_PROFILE = 'Profile';
    private static String FOLLOWUPTYPE_ACTIVITY = 'Activity';
    
    public static String getReportChartURL(String rsid, String cType, String legendLabel, String valueLabel){
        //ruid = runningUserId    // + '&ruid=' + ruid 
        //did = dashboard id    //+ '&did=' + did 
        String baseURL = URL.getSalesforceBaseUrl().toExternalForm().replace('visual.','sales').replace('c.na','na').replace('c.ap','ap');
        if (cType.equals('scatter')){    //scatter
            return baseURL + iPadUtilClass.REPORTCHART_URL3 + '&rsid=' + rsid+ '&dl1=' + legendLabel + '&vl0=' + valueLabel + '&vl1=' + valueLabel + '&c=' + cType;
        }else if(cType.equals('gauge') ){
            return baseURL + iPadUtilClass.REPORTCHART_URL2 + '&rsid=' + rsid+ '&dl1=' + legendLabel + '&vl0=' + valueLabel + '&c=' + cType;
        }else{
            return baseURL + iPadUtilClass.REPORTCHART_URL1 + '&rsid=' + rsid+ '&dl1=' + legendLabel + '&vl0=' + valueLabel + '&c=' + cType;        
        }
    }

    public static String getBgImageNameBrowse(){
        return iPadUtilClass.BGIMAGE_NAMEBROWSE ;
    }

    public static String getBgImageName1(){
        return iPadUtilClass.BGIMAGE_NAME1 ;
    }
    public static String getBgImageName2(){
        return iPadUtilClass.BGIMAGE_NAME2 ;
    }
    public static String getBgImageName3(){
        return iPadUtilClass.BGIMAGE_NAME3 ;
    }
    public static String getBgImageName4(){
        return iPadUtilClass.BGIMAGE_NAME4 ;
    }
                
    public static String getLoginPageName(){
        return iPadUtilClass.PAGETYPE_LOGIN;
    }
    public static String getHomePageName(){
        return iPadUtilClass.PAGETYPE_HOME;
    }
    public static String getPage1Name(){
        return iPadUtilClass.PAGETYPE_PAGE1;
    }
    public static String getPage2Name(){
        return iPadUtilClass.PAGETYPE_PAGE2;
    }
    public static String getPage3Name(){
        return iPadUtilClass.PAGETYPE_PAGE3;
    }
    public static String getPage4Name(){
        return iPadUtilClass.PAGETYPE_PAGE4;
    }
    public static String getPage5Name(){
        return iPadUtilClass.PAGETYPE_PAGE5;
    }
    public static String getPage6Name(){
        return iPadUtilClass.PAGETYPE_PAGE6;
    }
    public static String getPage7Name(){
        return iPadUtilClass.PAGETYPE_PAGE7;
    }
    public static String getPage8Name(){
        return iPadUtilClass.PAGETYPE_PAGE8;
    }


    public static String getFollowUpTypeInterest(){
        return iPadUtilClass.FOLLOWUPTYPE_INTEREST;
    }
    public static String getFollowUpTypeProfile(){
        return iPadUtilClass.FOLLOWUPTYPE_PROFILE ;
    }
    public static String getFollowUpTypeActivity(){
        return iPadUtilClass.FOLLOWUPTYPE_ACTIVITY ;
    }


    public static String getBackgroundImage(String image, String url){
        if(image.equals(BGIMAGE_NAMEBROWSE)){
            return url;
        }else{
            return queryResourceURL('iPadBg') + '/' + image + '-bg.png';        
        }
    }

    //query the resource URL
    private static String queryResourceURL(String resourceName){
        List<StaticResource> resourceList= [SELECT Name, NamespacePrefix, SystemModStamp FROM StaticResource WHERE Name = :resourceName];
        // Checking if the result is returned or not
        if(resourceList.size() == 1){
            // Getting namespace
            String namespace = resourceList[0].NamespacePrefix;
            // Resource URL
            return '/resource/' + resourceList[0].SystemModStamp.getTime() + '/' + (namespace != null && namespace != '' ? namespace + '__' : '') + resourceName; 
        }
        else return '';
    }
    
    public static String getMonthFromNumber(Integer nMonth){
        if(nMonth==1){
            return 'January';
        }else if(nMonth==2){
            return 'February';            
        }else if(nMonth==3){
            return 'March';            
        }else if(nMonth==4){
            return 'April';            
        }else if(nMonth==5){
            return 'May';            
        }else if(nMonth==6){
            return 'June';            
        }else if(nMonth==7){
            return 'July';            
        }else if(nMonth==8){
            return 'August';            
        }else if(nMonth==9){
            return 'September';            
        }else if(nMonth==10){
            return 'October';            
        }else if(nMonth==11){
            return 'November';            
        }else if(nMonth==12){
            return 'December';            
        }    
        return '';
    }
}