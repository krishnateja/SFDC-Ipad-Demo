@isTest 
private class iPadDemoTestClass {

    static testMethod void iPadMakerTest() {
        settingsTest();
        runTest();
    }

    private static void settingsTest() {
        iPadMakerSettingsController settings = new iPadMakerSettingsController();
        settings.getIPadApplication();
        
        //create App
        Id iPadApp = createApp(settings);
        List<ApplicationImage__c> imageList = createImages(iPadApp, settings);
        List<ApplicationLink__c> linkList = createLinks(iPadApp, settings);
        List<ApplicationFollowUpItem__c> followupList = createFollowups(iPadApp, settings);
        //query images, links, followups
        queryImages(iPadApp, settings);
        queryLinks(iPadApp, settings);
        queryFollowup(iPadApp, settings);
        
        //update App
        updateApp(iPadApp, settings);
        updateImages(iPadApp, settings, imageList);
        updateLinks(iPadApp, settings, linkList);
        updateFollowups(iPadApp, settings, followupList );
        
        //get strings
        getStrings(settings);
        
        //testAccessURLEmail
        testAccessURLEmail(settings);
    }

    private static void testAccessURLEmail(iPadMakerSettingsController settings){        
        iPadMakerSettingsController.sendApplicationURL(settings.iPadApp.Id);
    }

    private static void getStrings(iPadMakerSettingsController settings){
        System.assertEquals(iPadUtilClass.getBgImageName1(), settings.getBgImageName1());
        System.assertEquals(iPadUtilClass.getBgImageName2(), settings.getBgImageName2());
        System.assertEquals(iPadUtilClass.getBgImageName3(), settings.getBgImageName3());
        System.assertEquals(iPadUtilClass.getBgImageName4(), settings.getBgImageName4());
        System.assertEquals(iPadUtilClass.getBgImageNameBrowse(), settings.getBgImageNameBrowse());

        System.assertEquals(iPadUtilClass.getLoginPageName(), settings.getLoginPageName());
        System.assertEquals(iPadUtilClass.getHomePageName(), settings.getHomePageName());
        System.assertEquals(iPadUtilClass.getPage1Name(), settings.getPage1Name());
        System.assertEquals(iPadUtilClass.getPage2Name(), settings.getPage2Name());
        System.assertEquals(iPadUtilClass.getPage3Name(), settings.getPage3Name());
        System.assertEquals(iPadUtilClass.getPage4Name(), settings.getPage4Name());
        System.assertEquals(iPadUtilClass.getPage5Name(), settings.getPage5Name());
        System.assertEquals(iPadUtilClass.getPage6Name(), settings.getPage6Name());
        System.assertEquals(iPadUtilClass.getPage7Name(), settings.getPage7Name());
        System.assertEquals(iPadUtilClass.getPage8Name(), settings.getPage8Name());

        System.assertEquals(iPadUtilClass.getFollowUpTypeInterest(), settings.getFollowUpInterest());
        System.assertEquals(iPadUtilClass.getFollowUpTypeProfile(), settings.getFollowUpProfile());
        System.assertEquals(iPadUtilClass.getFollowUpTypeActivity(), settings.getFollowUpActivity());
    }

    private static Id createApp(iPadMakerSettingsController settings){
        Id appId = iPadMakerSettingsController.saveApplication(new iPadApplication__c(
            Name = 'test app name',
            Active__c = true,
            ApplicationURL__c = '/apex/iPadDemo',
            BodyColor__c = '#eeeeee',
            BodyBgImage__c = '',
            BodyIsUseImage__c = false,
            FooterColor__c = '#aaaaaa',
            HeaderColor__c = '#000000',
            HeaderFontColor__c = '#eeeeee',
            FooterFontColor__c = '#333333',
            Home_Page_Title__c = 'Bank App',
            ChatterId__c = '',
            ChatterPositionX__c = 2,
            ChatterPositionY__c = 30,
            VisualforcePageName__c = '',
            VisualforcePageLocationX__c = 0,
            VisualforcePageLocationY__c = 10,
            AccountPersonName__c = true,
            AccountPersonEmail__c = true,
            AccountPersonBirthdate__c = true,
            AccountNumber__c = true,
            AccountType__c = true,
            AccountIndustry__c = true,
            AccountRating__c = true,
            AccountPhone__c = true,
            AccountAddress__c = true,
            AccountDescription__c = true,
            Page_1_Title__c = 'Page 1 Test',
            Page_2_Title__c = 'Page 2 Test',
            Page_3_Title__c = 'Page 3 Test',
            Page_4_Title__c = 'Page 4 Test',
            Page_5_Title__c = 'Page 5 Test',
            Page_6_Title__c = 'Page 6 Test',
            Page_1_Active__c = true,
            Page_2_Active__c = true,
            Page_3_Active__c = true,
            Page_4_Active__c = true,
            Page_5_Active__c = true,
            Page_6_Active__c = true,
            Page_7_Active__c = false,
            Page_8_Active__c = false,
            LoginBodyColor__c = '#888888',
            //LoginLabelColor__c = newApp.LoginLabelColor__c,
            //LoginLabelFontSize__c = newApp.LoginLabelFontSize__c,
            LoginButtonColor__c = '#ffffff',
            LoginButtonLabelColor__c = '#333333',
            Password__c = 'testpassword',
            Username__c = 'testusername'
        ));
        System.assertNotEquals(null, appId);        
        return appId;
    }

    private static void updateApp(Id appId, iPadMakerSettingsController settings){
        settings.getIPadApplication();
        System.assertEquals(appId, settings.iPadApp.Id);
        Id upsertAppId = iPadMakerSettingsController.saveApplication(new iPadApplication__c(
            Id = appId,
            Name = 'New Test App Name',
            Active__c = true,
            BodyColor__c = '#eeeeee',
            BodyBgImage__c = settings.getBgImageName2(),
            BodyIsUseImage__c = true,
            FooterColor__c = '#aaaaaa',
            HeaderColor__c = '#000000',
            HeaderFontColor__c = '#eeeeee',
            FooterFontColor__c = '#333333',
            ChatterId__c = '',
            ChatterPositionX__c = 2,
            ChatterPositionY__c = 30,
            DashboardId__c = '',
            VisualforcePageName__c = '',
            VisualforcePageLocationX__c = 0,
            VisualforcePageLocationY__c = 10,
            AccountPersonName__c = false,
            AccountPersonEmail__c = false,
            AccountPersonBirthdate__c = false,
            AccountNumber__c = true,
            AccountType__c = true,
            AccountIndustry__c = true,
            AccountRating__c = true,
            AccountPhone__c = true,
            AccountAddress__c = true,
            AccountDescription__c = true,
            Page_1_Title__c = 'Page 1 Test',
            Page_2_Title__c = 'Page 2 Test',
            Page_3_Title__c = 'Page 3 Test',
            Page_4_Title__c = 'Page 4 Test',
            Page_5_Title__c = 'Page 5 Test',
            Page_6_Title__c = 'Page 6 Test',
            Page_1_Active__c = true,
            Page_2_Active__c = true,
            Page_3_Active__c = true,
            Page_4_Active__c = true,
            Page_5_Active__c = true,
            Page_6_Active__c = false,
            Page_7_Active__c = false,
            Page_8_Active__c = false,
            LoginBodyColor__c = '#888888',
            LoginButtonColor__c = '#ffffff',
            LoginButtonLabelColor__c = '#333333',
            Password__c = 'testpassword',
            Username__c = 'testusername'
        ));
        System.assertEquals(appId, upsertAppId);
    }


    private static List<ApplicationImage__c> createImages(Id appId, iPadMakerSettingsController settings){
        //create Images
        List<ApplicationImage__c> insertImageList = new List<ApplicationImage__c>();
        //login image
        insertImageList.add(new ApplicationImage__c(
            Height__c = 200,
            Width__c = 500, 
            ImageURL__c = 'http://www.insidemobileapps.com/wp-content/uploads/2013/05/salesforce-logo.jpeg',
            LocationX__c = 0, 
            LocationY__c = 20, 
            PageType__c = settings.getLoginPageName(),
            IsFooterImage__c = false,
            IsDashboardImage__c = false,
            iPadApplication__c = appId
            )
        );

        //login image
        insertImageList.add(new ApplicationImage__c(
            Height__c = 200,
            Width__c = 500, 
            ImageURL__c = 'https://ifttt.com/images/channels_bw/salesforce_chatter_lrg.png',
            LocationX__c = 0, 
            LocationY__c = 20, 
            PageType__c = settings.getLoginPageName(),
            IsFooterImage__c = false,
            IsDashboardImage__c = false,
            iPadApplication__c = appId
            )
        );

        //page 1 footer
        insertImageList.add(new ApplicationImage__c(
            ImageURL__c = 'https://ifttt.com/images/channels/salesforce_chatter.png',
            Label__c = 'Chatter Footer',
            PageType__c = settings.getPage1Name(),
            iPadApplication__c = appId,
            IsFooterImage__c = true,
            IsDashboardImage__c = false
            )
        );

        //page 2 footer
        insertImageList.add(new ApplicationImage__c(
            ImageURL__c = 'http://cloudtimes.org/wp-content/uploads/2010/11/Salesforce-Marketing-Dashboard-150x150.jpg',
            Label__c = 'Dashboard Footer',
            PageType__c = settings.getPage2Name(),
            iPadApplication__c = appId,
            IsFooterImage__c = true,
            IsDashboardImage__c = false
            )
        );

        //dashboard 1
        insertImageList.add(new ApplicationImage__c(
            PageType__c = settings.getPage2Name(),
            iPadApplication__c = appId,
            IsFooterImage__c = false,
            IsDashboardImage__c = true,
            DashboardURL__c  = 'http://testdashboardimage.png',
            Height__c = 300,
            Width__c = 400,
            DasboardLegendLabel__c = 'Label 1',
            DasboardValueLabel__c = 'Label 2',
            DashboardFromURL__c = false,
            ChartType__c = 'pie',
            ReportId__c = 'testReportId'
            )
        );

        //dashboard 2
        insertImageList.add(new ApplicationImage__c(
            PageType__c = settings.getPage2Name(),
            iPadApplication__c = appId,
            IsFooterImage__c = false,
            IsDashboardImage__c = true,
            DashboardURL__c  = 'http://testdashboardimage2.png',
            Height__c = 300,
            Width__c = 400,
            DashboardFromURL__c = true
            )
        );

        //dashboard 3
        insertImageList.add(new ApplicationImage__c(
            PageType__c = settings.getPage2Name(),
            iPadApplication__c = appId,
            IsFooterImage__c = false,
            IsDashboardImage__c = true,
            Height__c = 300,
            Width__c = 400,
            DasboardLegendLabel__c = 'Label 1',
            DasboardValueLabel__c = 'Label 2',
            DashboardFromURL__c = false,
            ChartType__c = 'scatter',
            ReportId__c = 'testReportId'
            )
        ); 

        //dashboard 4
        insertImageList.add(new ApplicationImage__c(
            PageType__c = settings.getPage2Name(),
            iPadApplication__c = appId,
            IsFooterImage__c = false,
            IsDashboardImage__c = true,
            Height__c = 300,
            Width__c = 400,
            DasboardLegendLabel__c = 'Label 1',
            DasboardValueLabel__c = 'Label 2',
            DashboardFromURL__c = false,
            ChartType__c = 'gauge',
            ReportId__c = 'testReportId'
            )
        );

        //page 3 footer
        insertImageList.add(new ApplicationImage__c(
            ImageURL__c = 'http://cloudtimes.org/wp-content/uploads/2010/11/Salesforce-Marketing-Dashboard-150x150.jpg',
            Label__c = 'Create Account Footer',
            PageType__c = settings.getPage3Name(),
            iPadApplication__c = appId,
            IsFooterImage__c = true,
            IsDashboardImage__c = false
            )
        ); 

        //page 4 footer
        insertImageList.add(new ApplicationImage__c(
            ImageURL__c = 'http://cloudtimes.org/wp-content/uploads/2010/11/Salesforce-Marketing-Dashboard-150x150.jpg',
            Label__c = 'Learn Footer',
            PageType__c = settings.getPage4Name(),
            iPadApplication__c = appId,
            IsFooterImage__c = true,
            IsDashboardImage__c = false
            )
        ); 

        //page 5 footer
        insertImageList.add(new ApplicationImage__c(
            ImageURL__c = 'http://cloudtimes.org/wp-content/uploads/2010/11/Salesforce-Marketing-Dashboard-150x150.jpg',
            Label__c = 'Followup Footer',
            PageType__c = settings.getPage5Name(),
            iPadApplication__c = appId,
            IsFooterImage__c = true,
            IsDashboardImage__c = false
            )
        ); 

        //page 6 footer
        insertImageList.add(new ApplicationImage__c(
            ImageURL__c = 'http://cloudtimes.org/wp-content/uploads/2010/11/Salesforce-Marketing-Dashboard-150x150.jpg',
            Label__c = 'Custom App Footer',
            PageType__c = settings.getPage6Name(),
            iPadApplication__c = appId,
            IsFooterImage__c = true,
            IsDashboardImage__c = false
            )
        ); 

        //extra image
        insertImageList.add(new ApplicationImage__c(
            ImageURL__c = 'http://cloudtimes.org/wp-content/uploads/2010/11/Salesforce-Marketing-Dashboard-150x150.jpg',
            Label__c = 'Extra image',
            PageType__c = settings.getPage5Name(),
            iPadApplication__c = appId,
            IsFooterImage__c = false,
            IsDashboardImage__c = false
            )
        ); 
        
        List<ApplicationImage__c> imageList = iPadMakerSettingsController.saveImages(insertImageList, appId);
        System.assertEquals(insertImageList.size(), imageList.size());
        return imageList;
    }


    private static void queryImages(Id appId, iPadMakerSettingsController settings){
        List<ApplicationImage__c> loginImageList = iPadMakerSettingsController.queryLoginImages(appId);
        System.assertEquals(2, loginImageList.size());
        
        List<ApplicationImage__c> imageList = iPadMakerSettingsController.queryImages(appId, settings.getPage1Name(), true);
        System.assertEquals(1, imageList.size());
        System.assertEquals('Chatter Footer', imageList.get(0).Label__c );             

        imageList = iPadMakerSettingsController.queryImages(appId, settings.getPage2Name(), true);
        System.assertEquals(1, imageList.size());
        System.assertEquals('Dashboard Footer', imageList.get(0).Label__c );

        List<ApplicationImage__c> dashboardList = iPadMakerSettingsController.queryDashboardImages(appId);
        System.assertEquals(4, dashboardList.size());


        imageList = iPadMakerSettingsController.queryImages(appId, settings.getPage3Name(), true);
        System.assertEquals(1, imageList.size());
        System.assertEquals('Create Account Footer', imageList.get(0).Label__c );

        imageList = iPadMakerSettingsController.queryImages(appId, settings.getPage4Name(), true);
        System.assertEquals(1, imageList.size());
        System.assertEquals('Learn Footer', imageList.get(0).Label__c );

        imageList = iPadMakerSettingsController.queryImages(appId, settings.getPage5Name(), true);
        System.assertEquals(1, imageList.size());
        System.assertEquals('Followup Footer', imageList.get(0).Label__c );

        imageList = iPadMakerSettingsController.queryImages(appId, settings.getPage6Name(), true);
        System.assertEquals(1, imageList.size());
        System.assertEquals('Custom App Footer', imageList.get(0).Label__c );
        
        List<StaticResource> staticResourceList = iPadMakerSettingsController.queryStaticResource();
    }


    private static void updateImages(Id appId, iPadMakerSettingsController settings, List<ApplicationImage__c> imageList){
        List<ApplicationImage__c> upsertList = new List<ApplicationImage__c>();
        upsertList = imageList;
        //remove an image
        ApplicationImage__c remove1 = upsertList.get(upsertList.size()-1);
        upsertList.remove(upsertList.size()-1);
        //edit an image
        ApplicationImage__c image = upsertList.get(0);
        image.Height__c = 2000;
        image.Width__c = 1000;

        //add new image
        upsertList.add(new ApplicationImage__c(
            ImageURL__c = 'https://ifttt.com/images/channels/salesforce_chatter.png',
            Label__c = 'New Image',
            PageType__c = settings.getPage4Name(),
            iPadApplication__c = appId,
            IsFooterImage__c = false,
            IsDashboardImage__c = false
            )
        );

        List<ApplicationImage__c> removeList = new List<ApplicationImage__c>();
        removeList.add(remove1);
        
        List<ApplicationImage__c> imageUpsertList = iPadMakerSettingsController.saveImages(upsertList, appId);
        System.assertEquals(1, imageUpsertList.size());    //will only return new id
        iPadMakerSettingsController.removeImages(removeList);

    }

    private static List<ApplicationFollowUpItem__c> createFollowups(Id appId, iPadMakerSettingsController settings){
        List<ApplicationFollowUpItem__c> insertFollowupList= new List<ApplicationFollowUpItem__c>();
        //activity
        insertFollowupList.add(new ApplicationFollowUpItem__c(
            iPadApplication__c = appId,
            Type__c = settings.getFollowUpActivity(),
            PageType__c = iPadUtilClass.getPage5Name(),
            ActivityDate__c = Date.today().format(),
            CheckboxValue__c = false,
            IconURL__c = '',
            IsCheckbox__c = false,
            Label__c = 'Test Followup',
            SortNumber__c = 0,
            TextValue__c = 'Test Value'
            )
        );
        insertFollowupList.add(new ApplicationFollowUpItem__c(
            iPadApplication__c = appId,
            Type__c = settings.getFollowUpActivity(),
            PageType__c = iPadUtilClass.getPage5Name(),
            ActivityDate__c = Date.today().format(),
            CheckboxValue__c = false,
            IconURL__c = '',
            IsCheckbox__c = false,
            Label__c = 'Test Followup',
            SortNumber__c = 0,
            TextValue__c = 'Test Value'
            )
        );
        //profile
        insertFollowupList.add(new ApplicationFollowUpItem__c(
            iPadApplication__c = appId,
            Type__c = settings.getFollowUpProfile(),
            PageType__c = iPadUtilClass.getPage5Name(),
            ActivityDate__c = Date.today().format(),
            CheckboxValue__c = false,
            IconURL__c = '',
            IsCheckbox__c = false,
            Label__c = 'Test Followup',
            SortNumber__c = 0,
            TextValue__c = 'Test Value'
            )
        );
        //interest
        insertFollowupList.add(new ApplicationFollowUpItem__c(
            iPadApplication__c = appId,
            Type__c = settings.getFollowUpInterest(),
            PageType__c = iPadUtilClass.getPage5Name(),
            ActivityDate__c = '',
            CheckboxValue__c = true,
            IconURL__c = '',
            IsCheckbox__c = false,
            Label__c = 'Test Followup',
            SortNumber__c = 1,
            TextValue__c = 'Test Value'
            )
        );    
        insertFollowupList.add(new ApplicationFollowUpItem__c(
            iPadApplication__c = appId,
            Type__c = settings.getFollowUpInterest(),
            PageType__c = iPadUtilClass.getPage5Name(),
            ActivityDate__c = '',
            CheckboxValue__c = true,
            IconURL__c = '',
            IsCheckbox__c = true,
            Label__c = 'Test Followup',
            SortNumber__c = 1,
            TextValue__c = 'Test Value'
            )
        );    
        List<ApplicationFollowUpItem__c> followupList = iPadMakerSettingsController.saveFollowUpItems(insertFollowupList, appId);
        System.assertEquals(insertFollowupList.size(), followupList.size());    
        return followupList;
    }    

    private static List<ApplicationLink__c> createLinks(Id appId, iPadMakerSettingsController settings){        
        //create Links
        List<ApplicationLink__c> insertLinkList = new List<ApplicationLink__c>();
        //article 1
        insertLinkList.add(new ApplicationLink__c(
            Name = 'Article Link 1',
            IsArticle__c = true,
            IsVideo__c = false,
            PageType__c = settings.getPage4Name(),
            URL__c = 'google.com',
            iPadApplication__c = appId        
            )
        );
        //article 2
        insertLinkList.add(new ApplicationLink__c(
            Name = 'Article Link 2',
            IsArticle__c = true,
            IsVideo__c = false,
            PageType__c = settings.getPage4Name(),
            URL__c = 'gmail.com',
            iPadApplication__c = appId        
            )
        );
        //video 1
        insertLinkList.add(new ApplicationLink__c(
            Name = 'Video Link 1',
            IsArticle__c = false,
            IsVideo__c = true,
            PageType__c = settings.getPage4Name(),
            URL__c = 'youtube.com',
            iPadApplication__c = appId        
            )
        );
        List<ApplicationLink__c> linkList = iPadMakerSettingsController.saveLinks(insertLinkList, appId);
        System.assertEquals(insertLinkList.size(), linkList.size());    
        return linkList;
    }    

    private static void queryFollowup(Id appId, iPadMakerSettingsController settings){
        List<ApplicationFollowUpItem__c> followupActivityList = iPadMakerSettingsController.queryFollowUpItem(appId, settings.getFollowUpActivity());
        System.assertEquals(2, followupActivityList.size());
        List<ApplicationFollowUpItem__c> followupProfileList = iPadMakerSettingsController.queryFollowUpItem(appId, settings.getFollowUpProfile());
        System.assertEquals(1, followupProfileList.size());
        List<ApplicationFollowUpItem__c> followupInterestList = iPadMakerSettingsController.queryFollowUpItem(appId, settings.getFollowUpInterest());
        System.assertEquals(2, followupInterestList.size());
    }
 
    private static void queryLinks(Id appId, iPadMakerSettingsController settings){
        List<ApplicationLink__c> articleList = iPadMakerSettingsController.queryArticles(appId);
        System.assertEquals(2, articleList.size());    

        List<ApplicationLink__c> videoList = iPadMakerSettingsController.queryVideos(appId);
        System.assertEquals(1, videoList.size());    
    }

    private static void updateFollowups(Id appId, iPadMakerSettingsController settings, List<ApplicationFollowUpItem__c> followupList){
        List<ApplicationFollowUpItem__c> upsertList = new List<ApplicationFollowUpItem__c>();
        upsertList = followupList;
        //remove a followup
        ApplicationFollowUpItem__c remove1 = upsertList.get(upsertList.size()-1);
        upsertList.remove(upsertList.size()-1);
        //edit a followup
        ApplicationFollowUpItem__c followup = upsertList.get(0);
        followup.Label__c= 'New name';

        //add new followup
        upsertList.add(new ApplicationFollowUpItem__c(
            iPadApplication__c = appId,
            Type__c = settings.getFollowUpInterest(),
            PageType__c = iPadUtilClass.getPage5Name(),
            ActivityDate__c = '',
            CheckboxValue__c = true,
            IconURL__c = '',
            IsCheckbox__c = true,
            Label__c = 'Test Followup',
            SortNumber__c = 10,
            TextValue__c = 'Test Value'
            )
        );

        List<ApplicationFollowUpItem__c> removeList = new List<ApplicationFollowUpItem__c>();
        removeList.add(remove1);
        
        List<ApplicationFollowUpItem__c> followupUpsertList = iPadMakerSettingsController.saveFollowUpItems(upsertList, appId);
        System.assertEquals(1, followupUpsertList.size());    //will only return new id
        iPadMakerSettingsController.removeFollowUpItems(removeList);    
    }        

    private static void updateLinks(Id appId, iPadMakerSettingsController settings, List<ApplicationLink__c> linkList){
        List<ApplicationLink__c> upsertList = new List<ApplicationLink__c>();
        upsertList = linkList;
        //remove a link
        ApplicationLink__c remove1 = upsertList.get(upsertList.size()-1);
        upsertList.remove(upsertList.size()-1);
        //edit a link
        ApplicationLink__c link = upsertList.get(0);
        link.Name = 'New name';

        //add new link
        upsertList.add(new ApplicationLink__c(
            Name = 'Article Link New',
            IsArticle__c = true,
            IsVideo__c = false,
            PageType__c = settings.getPage5Name(),
            URL__c = 'gmail.com',
            iPadApplication__c = appId        
            )
        );

        List<ApplicationLink__c> removeList = new List<ApplicationLink__c>();
        removeList.add(remove1);
        
        List<ApplicationLink__c> linkUpsertList = iPadMakerSettingsController.saveLinks(upsertList, appId);
        System.assertEquals(1, linkUpsertList.size());    //will only return new id
        iPadMakerSettingsController.removeLinks(removeList);        
    }

    private static Account createTestAccount(){
        Account acc = new Account(
            Name = 'test account'            
        );
        insert acc;
        return acc;
    }
    
    private static void createTestTasks(Id accId){
        Task t = new Task(
            WhatId = accId,
            Priority = 'low',
            Status = 'new',
            Subject = 'test subject',
            ActivityDate = Date.today().addDays(1)
        );
        insert t;
        Event e = new Event(
            WhatId = accId,
            IsAllDayEvent = true,
            Subject = 'test subject',
            ActivityDate = Date.today().addDays(2)
        );
        insert e;
    }    

    private static void runTest() {
        IPadDemoController controller = new IPadDemoController();
        System.assertNotEquals(null, controller.iPadAppConfig);
        getDemoControllerStrings(controller);

        //login page
        testLoginPage(controller.iPadAppConfig.Id, controller.getLoginPageName(),
            controller.iPadAppConfig.username__c, controller.iPadAppConfig.password__c);

        //home page
        testHomePage(controller.iPadAppConfig.Id, controller.getHomePageName(),
            controller.iPadAppConfig.Page_1_Active__c,
            controller.iPadAppConfig.Page_2_Active__c,
            controller.iPadAppConfig.Page_3_Active__c,
            controller.iPadAppConfig.Page_4_Active__c,
            controller.iPadAppConfig.Page_5_Active__c,
            controller.iPadAppConfig.Page_6_Active__c,
            controller.iPadAppConfig.Page_7_Active__c,
            controller.iPadAppConfig.Page_8_Active__c
            );
        
        //page 1: Chatter
        testPage1(controller.iPadAppConfig.Id, controller.getPage1Name());

        //page 2: Dashboard
        testPage2(controller.iPadAppConfig.Id, controller.getPage2Name());
                
        //page 3: Create Account
        testPage3(controller.iPadAppConfig.Id, controller.getPage3Name(),
            false
            );
        testPage3(controller.iPadAppConfig.Id, controller.getPage3Name(),
            true
            );
        
        //page 4: Learning
        testPage4(controller.iPadAppConfig.Id, controller.getPage4Name());
        
        //page 5: Followup
        testPage5(controller.iPadAppConfig.Id, controller.getPage5Name());

        //page 6: Custom App: Ask
        testPage6(controller.iPadAppConfig.Id, controller.getPage6Name());         

        //page 7: Extra
        //testPage7(controller.iPadAppConfig.Id, controller.getPage7Name());         

        //page 8: Extra
        //testPage8(controller.iPadAppConfig.Id, controller.getPage8Name());         
    }
    
    private static void getDemoControllerStrings(IPadDemoController controller){
        System.assertEquals(iPadUtilClass.getLoginPageName(), controller.getLoginPageName());
        System.assertEquals(iPadUtilClass.getHomePageName(), controller.getHomePageName());
        System.assertEquals(iPadUtilClass.getPage1Name(), controller.getPage1Name());
        System.assertEquals(iPadUtilClass.getPage2Name(), controller.getPage2Name());
        System.assertEquals(iPadUtilClass.getPage3Name(), controller.getPage3Name());
        System.assertEquals(iPadUtilClass.getPage4Name(), controller.getPage4Name());
        System.assertEquals(iPadUtilClass.getPage5Name(), controller.getPage5Name());
        System.assertEquals(iPadUtilClass.getPage6Name(), controller.getPage6Name());
    }    
    
    private static void testLoginPage(String appId, String currentComponent, String username, String password){
        IPadDemoComponentController compController = new IPadDemoComponentController();
        compController.applicationId = appId;
        compController.currentComponent = currentComponent;
        compController.username = username;
        compController.password = password;
        List<ApplicationImage__c> imageList = compController.getImageList();
        System.assertEquals(iPadMakerSettingsController.queryLoginImages(appId).size(), imageList.size());
        List<ApplicationImage__c> logoList = compController.getLogoList();
        System.assertEquals(iPadMakerSettingsController.queryImages(appId, iPadUtilClass.getLoginPageName(), false).size(), logoList.size());
    }

    private static void testHomePage(String appId, String currentComponent, Boolean active1,
        Boolean active2, Boolean active3, Boolean active4, Boolean active5, Boolean active6,
        Boolean active7, Boolean active8){
        IPadDemoComponentController compController = new IPadDemoComponentController();
        compController.applicationId = appId;
        compController.currentComponent = currentComponent;
        compController.page1Active = active1;
        compController.page2Active = active2;
        compController.page3Active = active3;
        compController.page4Active = active4;
        compController.page5Active = active5;
        compController.page6Active = active6;
        compController.page7Active = active7;
        compController.page8Active = active8;

        List<ApplicationImage__c> imageList = compController.getImageList();
        System.assertEquals(iPadMakerSettingsController.queryImages(appId, iPadUtilClass.getHomePageName(), false).size(), imageList.size());
        List<ApplicationImage__c> menuList = compController.getMenuList();
        System.assertNotEquals(0, menuList.size());
    }
    
    //Chatter
    private static void testPage1(String appId, String currentComponent){
        IPadDemoComponentController compController = new IPadDemoComponentController();
        compController.applicationId = appId;
        compController.currentComponent = currentComponent;
        compController.getChatterIdParam();

        List<ApplicationImage__c> imageList = compController.getImageList();
        System.assertEquals(iPadMakerSettingsController.queryImages(appId, iPadUtilClass.getPage1Name(), false).size(), imageList.size());
    }
        
    //Dashboard
    private static void testPage2(String appId, String currentComponent){
        IPadDemoComponentController compController = new IPadDemoComponentController();
        compController.applicationId = appId;
        compController.currentComponent = currentComponent;
        
        List<ApplicationImage__c> imageList = compController.getImageList();
        System.assertEquals(iPadMakerSettingsController.queryImages(appId, iPadUtilClass.getPage2Name(), false).size(), imageList.size());

        List<ApplicationImage__c> dashboardList = compController.getDashboardImageList();
        System.assertEquals(iPadMakerSettingsController.queryDashboardImages(appId).size(), dashboardList.size());
    }    
    
    //Create New Account
    private static void testPage3(String appId, String currentComponent, Boolean isPerson){
        IPadDemoComponentController compController = new IPadDemoComponentController();
        compController.applicationId = appId;
        compController.currentComponent = currentComponent;
        compController.accountIsPerson = isPerson;
        
        List<ApplicationImage__c> imageList = compController.getImageList();
        System.assertEquals(iPadMakerSettingsController.queryImages(appId, iPadUtilClass.getPage3Name(), false).size(), imageList.size());

        if(isPerson){
            compController.contact.salutation = 'Mr.';
            compController.contact.firstName = 'First';
            compController.contact.lastName = 'Last';
            compController.contact.email = 'r@test.com';
            compController.contact.birthdate = Date.today();
        }else{
            compController.account.name = 'test account';        
        }
        compController.account.accountNumber = '123';
        compController.account.industry = 'test';
        compController.account.phone = '123456789';        
        compController.account.billingStreet = 'Street 1';
        compController.account.billingCity = 'City 1';
        compController.account.billingState = 'State 1';
        compController.account.billingCountry = 'Country 1';
        compController.account.description = 'description 1';
        compController.saveAccount();
        
        System.assertNotEquals(null, compController.account.Id);
        System.assertEquals('Account Saved', compController.message);
        
        compController.accountPersonNameCtrl = true;
        compController.accountBirthdateCtrl = true;
        compController.accountEmailCtrl = true;
        compController.accountNumberCtrl = true;
        compController.accountTypeCtrl = true;
        compController.accountIndustryCtrl = true;
        compController.accountRatingCtrl = true;
        compController.accountPhoneCtrl = true;
        compController.accountDescriptionCtrl = true;
        compController.accountAddressCtrl = true;
        compController.getAccountList();
    } 
    
    //Learning
    private static void testPage4(String appId, String currentComponent){
        IPadDemoComponentController compController = new IPadDemoComponentController();
        compController.applicationId = appId;
        compController.currentComponent = currentComponent;
        
        List<ApplicationImage__c> imageList = compController.getImageList();
        System.assertEquals(iPadMakerSettingsController.queryImages(appId, iPadUtilClass.getPage4Name(), false).size(), imageList.size());
        List<ApplicationLink__c> articleList = compController.getArticleList();
        System.assertEquals(iPadMakerSettingsController.queryArticles(appId).size(), articleList.size());
        List<ApplicationLink__c> videoList = compController.getVideoList();
        System.assertEquals(iPadMakerSettingsController.queryVideos(appId).size(), videoList.size());
    }    
    
    //Follow up
    private static void testPage5(String appId, String currentComponent){
        IPadDemoComponentController compController = new IPadDemoComponentController();
        compController.applicationId = appId;
        compController.currentComponent = currentComponent;
        compController.showTasks = false;
        compController.showEvents = false;
                        
        List<ApplicationImage__c> imageList = compController.getImageList();
        System.assertEquals(iPadMakerSettingsController.queryImages(appId, iPadUtilClass.getPage5Name(), false).size(), imageList.size());

        System.assertEquals(iPadUtilClass.getMonthFromNumber(Date.today().month()), compController.getCalendarMonth().month);
        compController.getPreviousMonth();
        System.assertEquals(iPadUtilClass.getMonthFromNumber(Date.today().addMonths(-1).month()), compController.getCalendarMonth().month);
        compController.getPreviousMonth();
        System.assertEquals(iPadUtilClass.getMonthFromNumber(Date.today().addMonths(-2).month()), compController.getCalendarMonth().month);
        compController.getPreviousMonth();
        System.assertEquals(iPadUtilClass.getMonthFromNumber(Date.today().addMonths(-3).month()), compController.getCalendarMonth().month);
        compController.getPreviousMonth();
        System.assertEquals(iPadUtilClass.getMonthFromNumber(Date.today().addMonths(-4).month()), compController.getCalendarMonth().month);
        compController.getPreviousMonth();
        System.assertEquals(iPadUtilClass.getMonthFromNumber(Date.today().addMonths(-5).month()), compController.getCalendarMonth().month);
        compController.getPreviousMonth();
        System.assertEquals(iPadUtilClass.getMonthFromNumber(Date.today().addMonths(-6).month()), compController.getCalendarMonth().month);
        compController.getPreviousMonth();
        System.assertEquals(iPadUtilClass.getMonthFromNumber(Date.today().addMonths(-7).month()), compController.getCalendarMonth().month);
        compController.getPreviousMonth();
        System.assertEquals(iPadUtilClass.getMonthFromNumber(Date.today().addMonths(-8).month()), compController.getCalendarMonth().month);
        compController.getPreviousMonth();
        System.assertEquals(iPadUtilClass.getMonthFromNumber(Date.today().addMonths(-9).month()), compController.getCalendarMonth().month);
        compController.getPreviousMonth();
        System.assertEquals(iPadUtilClass.getMonthFromNumber(Date.today().addMonths(-10).month()), compController.getCalendarMonth().month);
        compController.getPreviousMonth();
        System.assertEquals(iPadUtilClass.getMonthFromNumber(Date.today().addMonths(-11).month()), compController.getCalendarMonth().month);
        compController.getPreviousMonth();
        System.assertEquals(iPadUtilClass.getMonthFromNumber(Date.today().addMonths(-12).month()), compController.getCalendarMonth().month);

        compController.showDate = Date.today();
        compController.getNextMonth();
        System.assertEquals(iPadUtilClass.getMonthFromNumber(Date.today().addMonths(+1).month()), compController.getCalendarMonth().month);
        compController.getNextMonth();
        System.assertEquals(iPadUtilClass.getMonthFromNumber(Date.today().addMonths(+2).month()), compController.getCalendarMonth().month);
        compController.getNextMonth();
        System.assertEquals(iPadUtilClass.getMonthFromNumber(Date.today().addMonths(+3).month()), compController.getCalendarMonth().month);
        compController.getNextMonth();
        System.assertEquals(iPadUtilClass.getMonthFromNumber(Date.today().addMonths(+4).month()), compController.getCalendarMonth().month);
        compController.getNextMonth();
        System.assertEquals(iPadUtilClass.getMonthFromNumber(Date.today().addMonths(+5).month()), compController.getCalendarMonth().month);
        compController.getNextMonth();
        System.assertEquals(iPadUtilClass.getMonthFromNumber(Date.today().addMonths(+6).month()), compController.getCalendarMonth().month);
        compController.getNextMonth();
        System.assertEquals(iPadUtilClass.getMonthFromNumber(Date.today().addMonths(+7).month()), compController.getCalendarMonth().month);
        compController.getNextMonth();
        System.assertEquals(iPadUtilClass.getMonthFromNumber(Date.today().addMonths(+8).month()), compController.getCalendarMonth().month);
        compController.getNextMonth();
        System.assertEquals(iPadUtilClass.getMonthFromNumber(Date.today().addMonths(+9).month()), compController.getCalendarMonth().month);
        compController.getNextMonth();
        System.assertEquals(iPadUtilClass.getMonthFromNumber(Date.today().addMonths(+10).month()), compController.getCalendarMonth().month);
        compController.getNextMonth();
        System.assertEquals(iPadUtilClass.getMonthFromNumber(Date.today().addMonths(+11).month()), compController.getCalendarMonth().month);
        compController.getNextMonth();
        System.assertEquals(iPadUtilClass.getMonthFromNumber(Date.today().addMonths(+12).month()), compController.getCalendarMonth().month);

        System.assertEquals(0, compController.getTaskDateList().size());

        //create test account data + tasks
        Account acc = createTestAccount();
        createTestTasks(acc.Id);
        System.assertEquals(0, compController.getTaskDateList().size());

        compController.showTasks = true;
        System.assertEquals(1, compController.getTaskDateList().size());

        compController.showEvents = true;
        System.assertEquals(2, compController.getTaskDateList().size());

        compController.chosenTaskAccountId = acc.Id;
        compController.refreshAccountMap();
        
        List<ApplicationFollowUpItem__c> followupActivityList = compController.getFollowUpActivityItem();
        System.assertEquals(iPadMakerSettingsController.queryFollowUpItem(appId, iPadUtilClass.getFollowUpTypeActivity()).size(), followupActivityList.size());

        List<ApplicationFollowUpItem__c> followupProfileList = compController.getFollowUpProfileItem();
        System.assertEquals(iPadMakerSettingsController.queryFollowUpItem(appId, iPadUtilClass.getFollowUpTypeProfile()).size(), followupProfileList.size());

        List<ApplicationFollowUpItem__c> followupInterestList = compController.getFollowUpInterestItem();
        System.assertEquals(iPadMakerSettingsController.queryFollowUpItem(appId, iPadUtilClass.getFollowUpTypeInterest()).size(), followupInterestList.size());

    }    
    //Custom App: Ask
    private static void testPage6(String appId, String currentComponent){
        IPadDemoComponentController compController = new IPadDemoComponentController();
        compController.applicationId = appId;
        compController.currentComponent = currentComponent;
        
        List<ApplicationImage__c> imageList = compController.getImageList();
        System.assertEquals(iPadMakerSettingsController.queryImages(appId, iPadUtilClass.getPage6Name(), false).size(), imageList.size());
    }       
}