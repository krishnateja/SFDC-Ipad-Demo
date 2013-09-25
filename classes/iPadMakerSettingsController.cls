public class iPadMakerSettingsController{
    public iPadApplication__c iPadApp{get; set;}
    public List<ApplicationImage__c> loginImageList{get; set;}


    public iPadMakerSettingsController(){
    }

    public String getFollowUpActivity(){
        return iPadUtilClass.getFollowUpTypeActivity();    
    }

    public String getFollowUpInterest(){
        return iPadUtilClass.getFollowUpTypeInterest();    
    }

    public String getFollowUpProfile(){
        return iPadUtilClass.getFollowUpTypeProfile();    
    }

    public String getBgImageName1(){
        return iPadUtilClass.getBgImageName1();
    }
    public String getBgImageName2(){
        return iPadUtilClass.getBgImageName2();
    }
    public String getBgImageName3(){
        return iPadUtilClass.getBgImageName3();
    }
    public String getBgImageName4(){
        return iPadUtilClass.getBgImageName4() ;
    }
    public String getBgImageNameBrowse(){
        return iPadUtilClass.getBgImageNameBrowse() ;
    }                
    public String getLoginPageName(){
        return iPadUtilClass.getLoginPageName();
    }
    public String getHomePageName(){
        return iPadUtilClass.getHomePageName();
    }
    public String getPage1Name(){
        return iPadUtilClass.getPage1Name();
    }
    public String getPage2Name(){
        return iPadUtilClass.getPage2Name();
    }
    public String getPage3Name(){
        return iPadUtilClass.getPage3Name();
    }
    public String getPage4Name(){
        return iPadUtilClass.getPage4Name();
    }
    public String getPage5Name(){
        return iPadUtilClass.getPage5Name();
    }
    public String getPage6Name(){
        return iPadUtilClass.getPage6Name();
    }
    public String getPage7Name(){
        return iPadUtilClass.getPage7Name();
    }
    public String getPage8Name(){
        return iPadUtilClass.getPage8Name();
    }
    
    public void getIPadApplication(){
        List<iPadApplication__c> iPadAppList = queryApplication();
        if(iPadAppList!=null && iPadAppList.size()>0){
            iPadApp = iPadAppList.get(0);
        }
    }

    private List<iPadApplication__c> queryApplication(){
        return [select Id, Name, ApplicationURL__c, BodyColor__c, AboutText__c,
                FooterFontColor__c, HeaderFontColor__c, FooterColor__c, HeaderColor__c, Home_Page_Title__c,
                Page_1_Title__c, Page_2_Title__c, Page_3_Title__c, Page_4_Title__c, 
                Page_5_Title__c, Page_6_Title__c, Page_7_Title__c, Page_8_Title__c,
                LoginButtonColor__c, LoginButtonLabelColor__c, 
                LoginLabelColor__c, LogoURL__c, Password__c, Username__c, 
                LoginBodyColor__c, 
                Page_1_Active__c, Page_2_Active__c, Page_3_Active__c, Page_4_Active__c, 
                Page_5_Active__c, Page_6_Active__c, Page_7_Active__c, Page_8_Active__c,
                ChatterId__c, ChatterPositionX__c, ChatterPositionY__c,
                DashboardId__c, DashboardPositionX__c, DashboardPositionY__c, 
                VisualforcePageName__c, VisualforcePageLocationX__c, VisualforcePageLocationY__c,
                AccountNumber__c, AccountType__c, AccountIndustry__c, AccountRating__c,
                AccountPhone__c, AccountAddress__c, AccountDescription__c,
                AccountPersonBirthdate__c, AccountPersonName__c, AccountPersonEmail__c,
                BodyBgImage__c, BodyIsUseImage__c, BodyBgImageURL__c,
                LoginIsUseImage__c, LoginBgImage__c, LoginBgImageURL__c,
                FollowUpMapHeight__c, FollowUpMapWidth__c, FollowUpMapZoom__c, FollowUpShowEvents__c, FollowUpShowTasks__c,
                FollowUpActivitiesLabel__c, FollowUpInterestLabel__c, FollowUpProfileLabel__c,
                FollowUpButton1BgColor__c, FollowUpButton1FontColor__c, FollowUpButton1Label__c,
                FollowUpButton2BgColor__c, FollowUpButton2FontColor__c, FollowUpButton2Label__c, 
                FollowUpContactImageURL__c, FollowUpContactTwitterHandle__c, IsTwoCol__c
                from iPadApplication__c where Active__c=true limit 1];
    }

    @RemoteAction
    public static List<ApplicationFollowUpItem__c> queryFollowUpItem(Id appId, String followUpType){
        return [select Id, ActivityDate__c, CheckboxValue__c, IconURL__c, IsCheckbox__c, Label__c,
             iPadApplication__c, PageType__c, TextValue__c, Type__c, SortNumber__c
             from ApplicationFollowUpItem__c where iPadApplication__c=:appId and PageType__c=:iPadUtilClass.getPage5Name()
             and Type__c=:followUpType order by SortNumber__c, Name];
    }

    @RemoteAction
    public static List<ApplicationLink__c > queryVideos(Id appId){
        return [select Id, Name, IsArticle__c, IsVideo__c, PageType__c, URL__c 
            from ApplicationLink__c where iPadApplication__c=:appId 
            and PageType__c=:iPadUtilClass.getPage4Name() and IsVideo__c=true order by Name];
    }

    @RemoteAction
    public static List<ApplicationLink__c > queryArticles(Id appId){
        return [select Id, Name, IsArticle__c, IsVideo__c, PageType__c, URL__c 
            from ApplicationLink__c where iPadApplication__c=:appId 
            and PageType__c=:iPadUtilClass.getPage4Name() and IsArticle__c=true order by Name];
    }

    @RemoteAction
    public static List<ApplicationImage__c> queryLoginImages(Id appId){
        return [select Id, Name, Height__c, ImageURL__c, LocationX__c, LocationY__c, Width__c, PageType__c
            from ApplicationImage__c where iPadApplication__c=:appId 
            and PageType__c=:iPadUtilClass.getLoginPageName() order by Name];
    }



    @RemoteAction
    public static List<ApplicationImage__c> queryImages(Id appId, String pageType, Boolean isFooter){
        return [select Id, Name, Height__c, ImageURL__c, LocationX__c, LocationY__c, Width__c, PageType__c, 
            Label__c, LabelFontSize__c, LabelLocationX__c, LabelLocationY__c, IsFooterImage__c
            from ApplicationImage__c where iPadApplication__c=:appId 
            and PageType__c=:pageType and IsFooterImage__c=:isFooter and IsDashboardImage__c=false order by Name];
    }

    @RemoteAction
    public static List<ApplicationImage__c> queryDashboardImages(Id appId){
        return [select Id, Name, Height__c, ImageURL__c, LocationX__c, LocationY__c, Width__c, PageType__c, IsDashboardImage__c,
            Label__c, LabelFontSize__c, LabelLocationX__c, LabelLocationY__c, IsFooterImage__c, 
            DashboardURL__c, ChartType__c, ReportId__c, DashboardFromURL__c, DasboardValueLabel__c, DasboardLegendLabel__c
            from ApplicationImage__c where iPadApplication__c=:appId 
            and PageType__c=:iPadUtilClass.getPage2Name() and IsDashboardImage__c=true order by Name];
    }

    @RemoteAction
    public static List<StaticResource> queryStaticResource(){
        return [select Name, NamespacePrefix, ContentType from StaticResource where ContentType like '%image%' order by Name];
    }


    @RemoteAction
    public static Id saveApplication(iPadApplication__c newApp){
        if(String.isEmpty(newApp.Id)){
            iPadApplication__c insertApp = newApp.clone();
            insertApp.Active__c = true;
            insert insertApp;
            return insertApp.Id;            
        }else{
            upsert newApp; 
            return newApp.Id;            
        }
    }

    @RemoteAction
    public static List<ApplicationImage__c> saveImages(ApplicationImage__c[] imageList, Id appId){
        List<ApplicationImage__c> toUpsertList = new List<ApplicationImage__c>();
        List<ApplicationImage__c> toInsertList = new List<ApplicationImage__c>();
        for(ApplicationImage__c image : imageList){
            if(String.isEmpty(image.Id)){
                ApplicationImage__c insertImage = image.clone();
                insertImage.iPadApplication__c = appId;            
                toInsertList.add(insertImage);          
            }else{
                toUpsertList.add(image);
            }
        }
        upsert toUpsertList;
        insert toInsertList;
        return toInsertList;
    }

    @RemoteAction
    public static List<ApplicationLink__c> saveLinks(ApplicationLink__c [] linkList, Id appId){
        List<ApplicationLink__c > toUpsertList = new List<ApplicationLink__c >();
        List<ApplicationLink__c > toInsertList = new List<ApplicationLink__c >();
        for(ApplicationLink__c link : linkList){
            if(String.isEmpty(link.Id)){
                ApplicationLink__c insertLink = link.clone();
                insertLink.iPadApplication__c = appId;            
                toInsertList.add(insertLink);
            }else{
                toUpsertList.add(link);
            }
        }
        upsert toUpsertList;
        upsert toInsertList;
        return toInsertList;
    }

    @RemoteAction
    public static List<ApplicationFollowUpItem__c> saveFollowUpItems(ApplicationFollowUpItem__c[] followUpList, Id appId){
        List<ApplicationFollowUpItem__c> toUpsertList = new List<ApplicationFollowUpItem__c>();
        List<ApplicationFollowUpItem__c> toInsertList = new List<ApplicationFollowUpItem__c>();
        for(ApplicationFollowUpItem__c followUp : followUpList){
            if(String.isEmpty(followUp.Id)){
                ApplicationFollowUpItem__c insertFollowup = followUp.clone();
                insertFollowup.iPadApplication__c = appId;            
                toInsertList.add(insertFollowup);
            }else{
                toUpsertList.add(followUp);
            }
        }
        upsert toUpsertList;
        upsert toInsertList;
        return toInsertList;
    }
    
    @RemoteAction
    public static void removeImages(ApplicationImage__c[] imageList){
        delete imageList;
    }
    @RemoteAction
    public static void removeLinks(ApplicationLink__c [] linkList){
        delete linkList;
    }
    @RemoteAction
    public static void removeFollowUpItems(ApplicationFollowUpItem__c[] followUpList){
        delete followUpList;
    }

    @RemoteAction
    public static String sendApplicationURL(String id){
        iPadApplication__c app = [select ApplicationURL__c, Username__c, Password__c from iPadApplication__c where id=:id];
        String emailURL ='';
        if(app!=null){
            emailURL = 'https://www.salesforce.com/login.jsp?&un=' + app.Username__c + '&pw=' + app.Password__c + '&startURL=' + app.ApplicationURL__c;
            try {
                Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                message.setReplyTo('riezel.ramos@salesforce.com');
                message.setSaveAsActivity(false);
                message.setSubject('Your iPad Demo App URL');
    
                message.setTargetObjectId(UserInfo.getUserId());
                message.setPlainTextBody('Access your iPad Demo from here: ' + emailURL
                    + '. \nPlease raise an SSE assist if you would like a config file created.'
                );
    
                message.setToAddresses(new String[] { UserInfo.getUserEmail() });
                Messaging.SendEmailResult[] results = Messaging.sendEmail(new Messaging.SingleEmailMessage[] { message });
    
            } catch (Exception ce) {
                System.debug('DEBUGGG: ' + ce);
            }
        }
        return emailURL;

    }
}