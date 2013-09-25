public class IPadDemoComponentController{
    public Id applicationId{get; set;}
    public String username{get; set;}
    public String password{get; set;}
    public String bgImage {get; set;}
    public String currentComponent{get; set;}

    public Boolean accountIsPerson{get; set;}
    public Boolean accountPersonNameCtrl{get; set;}
    public Boolean accountNumberCtrl{get; set;}
    public Boolean accountTypeCtrl{get; set;}
    public Boolean accountIndustryCtrl{get; set;}
    public Boolean accountRatingCtrl{get; set;}
    public Boolean accountPhoneCtrl{get; set;}
    public Boolean accountAddressCtrl{get; set;}
    public Boolean accountDescriptionCtrl{get; set;}
    public Boolean accountBirthdateCtrl{get; set;}
    public Boolean accountEmailCtrl{get; set;}
    
    public Account account{ get; set;}
    public Contact contact{ get; set;}
    public Boolean page1Active{get; set;}
    public Boolean page2Active{get; set;}
    public Boolean page3Active{get; set;}
    public Boolean page4Active{get; set;}
    public Boolean page5Active{get; set;}
    public Boolean page6Active{get; set;}
    public Boolean page7Active{get; set;}
    public Boolean page8Active{get; set;}
    public String message{get; set;}
    public String chatterId{get; set;}

    public Boolean showEvents{get; set;}
    public Boolean showTasks{get; set;}
    public Date showDate{get; set;}

    public Account accountMap{get; set;}        
    public String chosenTaskAccountId{get; set;}    
    
    public IPadDemoComponentController(){
        account = new Account();
        contact = new Contact();
        chosenTaskAccountId = '';
        showDate= Date.today();
    }
    
    
    public void getChatterIdParam(){
        chatterId = ApexPages.currentPage().getParameters().get('id');
    }
    
    public PageReference saveAccount(){
        if(accountIsPerson){
            //account.RecordTypeId = [SELECT Id, Name, SobjectType, IsPersonType FROM RecordType WHERE SobjectType='Account' AND IsPersonType=True].Id;
            //System.debug('DEBUGGG recordTypeId: ' + account.RecordTypeId);
            /*account.Salutation = contact.salutation;
            account.firstname = contact.firstName;
            account.lastname = contact.lastName;
            account.PersonBirthdate = contact.birthdate;
            account.PersonEmail = contact.email;
            */
            account.Name = contact.salutation + ' ' + contact.firstName + ' ' + contact.lastName;
            insert contact;
        }
        insert account;

        message = 'Account Saved';
        return null;
    }


    public List<Account> getAccountList(){
        String queryString = 'select Name, ';
        if(accountNumberCtrl){
            queryString += 'accountNumber, ';            
        }
        if(accountTypeCtrl){
            queryString += 'type, ';            
        }
        if(accountIndustryCtrl){
            queryString += 'industry, ';            
        }
        if(accountRatingCtrl){
            queryString += 'rating, ';            
        }
        if(accountPhoneCtrl){
            queryString += 'phone, ';            
        }
        if(accountDescriptionCtrl){
            queryString += 'description, ';            
        }
        if(accountAddressCtrl){
            queryString += 'billingStreet, billingCity, billingState, billingCountry, ';
        }
        //remove last comma
        queryString = queryString.substring(0, queryString.length()-2);
        queryString += ' from Account order by LastModifiedDate desc';
        System.debug('DEBUGGG: '+queryString);
        return Database.query(queryString);
    }

    public List<ApplicationLink__c > getVideoList(){
        return [select Id, Name, IsArticle__c, IsVideo__c, PageType__c, URL__c 
            from ApplicationLink__c where iPadApplication__c=:applicationId
            and PageType__c=:currentComponent and IsVideo__c=true order by Name];
    }

    public List<ApplicationLink__c > getArticleList(){
        return [select Id, Name, IsArticle__c, IsVideo__c, PageType__c, URL__c 
            from ApplicationLink__c where iPadApplication__c=:applicationId
            and PageType__c=:currentComponent and IsArticle__c=true order by Name];
    }

    public List<ApplicationFollowUpItem__c> getFollowUpActivityItem(){
        return [select ActivityDate__c, IconURL__c, Label__c
             from ApplicationFollowUpItem__c where iPadApplication__c=:applicationId
             and PageType__c=:currentComponent and Type__c=:iPadUtilClass.getFollowUpTypeActivity()
             order by SortNumber__c, Name];
    }

    public List<ApplicationFollowUpItem__c> getFollowUpInterestItem(){
            return [select Id, CheckboxValue__c, Label__c
                from ApplicationFollowUpItem__c where iPadApplication__c=:applicationId
                and PageType__c=:currentComponent and Type__c=:iPadUtilClass.getFollowUpTypeInterest()
                order by SortNumber__c, Name];
    }

    public List<ApplicationFollowUpItem__c> getFollowUpProfileItem(){
            return [select Id, IconURL__c, Label__c, TextValue__c
             from ApplicationFollowUpItem__c where iPadApplication__c=:applicationId
             and PageType__c=:currentComponent and Type__c=:iPadUtilClass.getFollowUpTypeProfile()
             order by SortNumber__c, Name];
    }

    public List<ApplicationImage__c> getLogoList(){
        return [select ImageURL__c from ApplicationImage__c where iPadApplication__c=:applicationId
            and PageType__c=:iPadUtilClass.getLoginPageName() and IsFooterImage__c=false and IsDashboardImage__c=false order by Name];
    }

    public List<ApplicationImage__c> getImageList(){
        return [select Id, Name, Height__c, ImageURL__c, LocationX__c, LocationY__c, Width__c, PageType__c 
            from ApplicationImage__c where iPadApplication__c=:applicationId
            and PageType__c=:currentComponent and IsFooterImage__c=false and IsDashboardImage__c=false order by Name];
    }

    private List<ApplicationImage__c> queryFooterImage(String pageType){
         return [select Id, Name, ImageURL__c, PageType__c, Label__c, FooterImageURL__c
            from ApplicationImage__c where iPadApplication__c=:applicationId
            and IsFooterImage__c=true 
            and PageType__c=:pageType order by Name limit 1];    
    }

    public List<ApplicationImage__c> getDashboardImageList(){
        List<ApplicationImage__c> dashboardList = new List<ApplicationImage__c>();
        for (ApplicationImage__c appImage : [select Id, Name, Height__c, DashboardURL__c, Width__c, PageType__c, Label__c,
            DashboardFromURL__c, ChartType__c, ReportId__c, DasboardValueLabel__c, DasboardLegendLabel__c
            from ApplicationImage__c where iPadApplication__c=:applicationId
            and PageType__c=:currentComponent and IsDashboardImage__c=true order by Name]){
                if(!appImage.DashboardFromURL__c){    //create url string
                    appImage.DashboardURL__c = iPadUtilClass.getReportChartURL(appImage.ReportId__c, appImage.ChartType__c,
                        appImage.DasboardLegendLabel__c, appImage.DasboardValueLabel__c);
                }
                dashboardList.add(appImage);
            }
        return dashboardList;
    }

    public List<ApplicationImage__c> getMenuList(){
        List<ApplicationImage__c> imageList = new List<ApplicationImage__c>();
        if(page1Active){
            imageList = queryFooterImage(iPadUtilClass.getPage1Name());
        }
        if(page2Active){
            for(ApplicationImage__c image : queryFooterImage(iPadUtilClass.getPage2Name())){
                imageList.add(image);
            }
        }        
        if(page3Active){
            for(ApplicationImage__c image : queryFooterImage(iPadUtilClass.getPage3Name())){
                imageList.add(image);
            }
        }
        if(page4Active){
            for(ApplicationImage__c image : queryFooterImage(iPadUtilClass.getPage4Name())){
                imageList.add(image);
            }
        }    
        if(page5Active){
            for(ApplicationImage__c image : queryFooterImage(iPadUtilClass.getPage5Name())){
                imageList.add(image);
            }
        }
        if(page6Active){
            for(ApplicationImage__c image : queryFooterImage(iPadUtilClass.getPage6Name())){
                imageList.add(image);
            }
        }
        if(page7Active){
            for(ApplicationImage__c image : queryFooterImage(iPadUtilClass.getPage7Name())){
                imageList.add(image);
            }
        }
        if(page8Active){
            for(ApplicationImage__c image : queryFooterImage(iPadUtilClass.getPage8Name())){
                imageList.add(image);
            }
        }
        return imageList;
    }
    
    public Account queryAccountInfo(){
        return [select Name, Id, Phone, BillingPostalCode, BillingStreet, BillingCity, BillingState, BillingCountry from Account where id=:chosenTaskAccountId];
    }
    
    public PageReference refreshAccountMap(){
        accountMap = queryAccountInfo();
        return null;
    }

    public PageReference getPreviousMonth(){
        showDate = showDate.addMonths(-1);
        return null;
    }
    public PageReference getNextMonth(){
        showDate = showDate.addMonths(1);
        return null;
    }

    public CalendarMonthContainer getCalendarMonth(){ 
        return new CalendarMonthContainer(showDate.toStartOfMonth());
    }

    public List<TaskDateList> getTaskDateList(){
        List<TaskDateList> taskDateList = new List<TaskDateList>();
        if(showTasks!=null && showEvents!=null){
            List<Date> activityDateList = new List<Date>();
            for(AggregateResult ar : [select ActivityDate from Task where //OwnerId=:UserInfo.getUserId() and
                ActivityDate>=TODAY group by ActivityDate order by ActivityDate limit 5 ]){
                activityDateList.add((Date)ar.get('ActivityDate'));
            }
            for(AggregateResult ar : [select ActivityDate from Event where //OwnerId=:UserInfo.getUserId() and
                ActivityDate>=TODAY group by ActivityDate order by ActivityDate limit 5 ]){
                activityDateList.add((Date)ar.get('ActivityDate'));
            }
            activityDateList.sort();
            Date prevDate = Date.today().addDays(-1);
            for(Date dateItem : activityDateList){
                if(dateItem!=prevDate){
                    TaskDateList tdl = new TaskDateList(dateItem, showTasks, showEvents);
                    if((tdl.taskList!=null && tdl.taskList.size()>0) || (tdl.eventList!=null && tdl.eventList.size()>0)){
                        taskDateList.add(tdl);
                    }
                    prevDate = dateItem;
                }
            }
        }
        return taskDateList;
    }

    public class TaskDateList{
        public String activityDate {get; set;}
        public List<Task> taskList{get; set;}
        public List<Event> eventList{get; set;}

        public TaskDateList(Date d, Boolean bTask, Boolean bEvent){
            activityDate = d.format();
            taskList = new List<Task>();
            eventList = new List<Event>();
            if(bTask){
                taskList = queryTask(d);            
            }
            if(bEvent){
                eventList = queryEvent(d);            
            }
        }
        
        private List<Task> queryTask(Date d){
            return [select AccountId, ActivityDate, Description, Subject from Task 
            where //OwnerId=:UserInfo.getUserId() and 
            ActivityDate=:d
            order by ActivityDate desc];
        }

        private List<Event> queryEvent(Date d){
            return [select AccountId, ActivityDate, Description, Subject, StartDateTime, IsAllDayEvent from Event
            where //OwnerId=:UserInfo.getUserId() and 
            ActivityDate=:d
            order by ActivityDate desc];
        }
    }
    
    public class CalendarMonthContainer{
        public String month {get; set;}
        public List<CalendarWeekContainer> weekList {get;set;}
        public CalendarMonthContainer(Date startDate){
            this.month = iPadUtilClass.getMonthFromNumber(startDate.month());
            weekList = new List<CalendarWeekContainer>();

            Integer nDays = 7;
            Date tempDate = startDate;
            do{
                weekList.add(new CalendarWeekContainer(tempDate));
                tempDate = tempDate.addDays(nDays);
            }while(tempDate.month()==startDate.month());
            //last week
            if(tempDate.toStartOfWeek().month()==startDate.month()){
                weekList.add(new CalendarWeekContainer(tempDate));            
            }

        }    
    }
    public class CalendarWeekContainer{
        public List<String> dayList{get; set;}
        public CalendarWeekContainer(Date startDate){
            dayList = new List<String>();
            Date startWeekDate = startDate.toStartOfWeek(); 
            for(Integer i=0; i<7; i++){
                if(startDate.month()==startWeekDate.addDays(i).month()){
                    dayList.add(String.valueOf(startWeekDate.addDays(i).day()));
                }else{
                    dayList.add('');
                }

            }
        }
    }

}