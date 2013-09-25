public class IPadDemoController {
    public iPadApplication__c iPadAppConfig{get; set;}
    public List<ApplicationImage__c> footerImageList{get; set;}
    public String bgImage{get; set;} 
    public String loginImage{get; set;} 

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
    public IPadDemoController(){
        List<iPadApplication__c> appList = [select Name, ApplicationURL__c, BodyColor__c, AboutText__c ,
                FooterFontColor__c, HeaderFontColor__c, FooterColor__c, HeaderColor__c, Home_Page_Title__c,
                Page_1_Title__c, Page_2_Title__c, Page_3_Title__c, Page_4_Title__c, 
                Page_5_Title__c, Page_6_Title__c, Page_7_Title__c, Page_8_Title__c,
                LoginButtonColor__c, LoginButtonLabelColor__c, 
                LoginLabelColor__c, LogoURL__c,
                BodyBgImage__c, BodyIsUseImage__c, BodyBgImageURL__c,
                LoginIsUseImage__c, LoginBgImage__c, LoginBgImageURL__c,                
                FollowUpMapHeight__c, FollowUpMapWidth__c, FollowUpMapZoom__c,
                FollowUpShowEvents__c, FollowUpShowTasks__c,
                FollowUpActivitiesLabel__c, FollowUpInterestLabel__c, FollowUpProfileLabel__c,
                FollowUpButton1BgColor__c, FollowUpButton1FontColor__c, FollowUpButton1Label__c,
                FollowUpButton2BgColor__c, FollowUpButton2FontColor__c, FollowUpButton2Label__c,
                FollowUpContactImageURL__c, FollowUpContactTwitterHandle__c,
                Password__c, Username__c, LoginBodyColor__c,
                Page_1_Active__c, Page_2_Active__c, Page_3_Active__c, Page_4_Active__c, 
                Page_5_Active__c, Page_6_Active__c, Page_7_Active__c, Page_8_Active__c, 
                ChatterId__c, ChatterPositionX__c, ChatterPositionY__c,
                DashboardId__c, DashboardPositionX__c, DashboardPositionY__c,
                VisualforcePageName__c, VisualforcePageLocationX__c, VisualforcePageLocationY__c,
                AccountNumber__c, AccountType__c, AccountIndustry__c, AccountRating__c, 
                AccountPhone__c, AccountAddress__c, AccountDescription__c,
                AccountPersonName__c, AccountPersonBirthdate__c, AccountPersonEmail__c, IsTwoCol__c
                from iPadApplication__c where Active__c=true limit 1];

        if(appList!=null && appList.size()>0){
            iPadAppConfig = appList.get(0);
            if(iPadAppConfig.BodyIsUseImage__c){
                bgImage = iPadUtilClass.getBackgroundImage(iPadAppConfig.BodyBgImage__c, iPadAppConfig.BodyBgImageURL__c);
            }else{
                bgImage = 'none';
            }
            if(iPadAppConfig.LoginIsUseImage__c){
                loginImage = iPadUtilClass.getBackgroundImage(iPadAppConfig.LoginBgImage__c, iPadAppConfig.LoginBgImageURL__c);
            }else{
                loginImage = 'none';
            }
            if(String.isEmpty(iPadAppConfig.ChatterId__c)){
                iPadAppConfig.ChatterId__c = UserInfo.getUserId(); //show user feed by default
            }
            
            footerImageList = initFooterImageList();
        }    
    }

    private List<ApplicationImage__c> queryFooterImage(String pageType){
         return [select Id, Name, ImageURL__c, Label__c, FooterImageURL__c
            from ApplicationImage__c where iPadApplication__c=:iPadAppConfig.Id
            and IsFooterImage__c=true 
            and PageType__c=:pageType order by Name limit 1];    
    }

    public List<ApplicationImage__c> initFooterImageList(){
        List<ApplicationImage__c> imageList = new List<ApplicationImage__c>();
        if(iPadAppConfig.Page_1_Active__c){
            imageList = queryFooterImage(getPage1Name());
        }
        if(iPadAppConfig.Page_2_Active__c){
            for(ApplicationImage__c image : queryFooterImage(getPage2Name())){
                imageList.add(image);
            }
        }
        if(iPadAppConfig.Page_3_Active__c){
            for(ApplicationImage__c image : queryFooterImage(getPage3Name())){
                imageList.add(image);
            }
        }
        if(iPadAppConfig.Page_4_Active__c){
            for(ApplicationImage__c image : queryFooterImage(getPage4Name())){
                imageList.add(image);
            }
        }
        if(iPadAppConfig.Page_5_Active__c){
            for(ApplicationImage__c image : queryFooterImage(getPage5Name())){
                imageList.add(image);
            }
        }        
        if(iPadAppConfig.Page_6_Active__c){
            for(ApplicationImage__c image : queryFooterImage(getPage6Name())){
                imageList.add(image);
            }
        }        
        if(iPadAppConfig.Page_7_Active__c){
            for(ApplicationImage__c image : queryFooterImage(getPage7Name())){
                imageList.add(image);
            }
        }        
        if(iPadAppConfig.Page_8_Active__c){
            for(ApplicationImage__c image : queryFooterImage(getPage8Name())){
                imageList.add(image);
            }
        }        
        return imageList;
    }


}