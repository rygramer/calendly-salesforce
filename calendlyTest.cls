@IsTest
public class calendlyTest {
    @IsTest
    static void testing_successful_mapping1(){
        CalendlyAction__c action = new CalendlyAction__c(
            CustomQuestion1__c = 'Budget',
            CustomResponse1__c = '$1,000,000',
            CustomQuestion2__c = 'Top challenges',
            CustomResponse2__c = 'Being awesome',
            CustomQuestion3__c = 'Company size',
            CustomResponse3__c = '15 people',
            CustomQuestion4__c = 'Solution you’re interested in',
            CustomResponse4__c = 'Consulting'
        );

        calendly.InputParameters input = new calendly.InputParameters();
        input.inputAction = action;
        
        List<calendly.InputParameters> inputs = new List<calendly.InputParameters>();
        inputs.add(input);

        Test.startTest();
        	List<calendly.OutputParameters> outputs = calendly.mapping(inputs);
        Test.stopTest();
        
        system.assertEquals(action.CustomResponse1__c, outputs[0].outputAction.Budget__c);
        system.assertEquals(action.CustomResponse2__c, outputs[0].outputAction.Top_Challenges__c);
        system.assertEquals(action.CustomResponse3__c, outputs[0].outputAction.Company_Size__c);
        system.assertEquals(action.CustomResponse4__c, outputs[0].outputAction.Solution_you_re_interested_in__c);
        system.assertEquals(TRUE, String.isBlank(outputs[0].outputAction.Why_are_you_a_good_fit__c));
        system.assertEquals(TRUE, String.isBlank(outputs[0].outputAction.Which_position_are_you_interested_in__c));
        system.assertEquals(TRUE, String.isBlank(outputs[0].outputAction.Salary_Requirements__c));
        system.assertEquals(TRUE, String.isBlank(outputs[0].outputAction.LinkedIn_URL__c));
        system.assertEquals(0, outputs[0].outputErrors.size());
        
    }
    
    @IsTest
    static void testing_successful_mapping_enmasse(){
        CalendlyAction__c action = new CalendlyAction__c(
        	CustomQuestion1__c = 'Why are you a good fit?',
            CustomResponse1__c = 'I work hard.',
            CustomQuestion2__c = 'Which position are you interested in?',
            CustomResponse2__c = 'SOS',
            CustomQuestion3__c = 'Salary requirements',
            CustomResponse3__c = '$1,000,000',
            CustomQuestion4__c = 'LinkedIn URL',
            CustomResponse4__c = 'linkedin.com'
        );
        
        List<calendly.InputParameters> inputs = new List<calendly.InputParameters>();
        for(Integer i = 1; i<=201; i++){
            calendly.InputParameters input = new calendly.InputParameters();
        	input.inputAction = action;
            inputs.add(input);
        }

        Test.startTest();
        	List<calendly.OutputParameters> outputs = calendly.mapping(inputs);
        Test.stopTest();
        
        system.assertEquals(TRUE, String.isBlank(outputs[0].outputAction.Budget__c));
        system.assertEquals(TRUE, String.isBlank(outputs[0].outputAction.Top_Challenges__c));
        system.assertEquals(TRUE, String.isBlank(outputs[0].outputAction.Company_Size__c));
        system.assertEquals(TRUE, String.isBlank(outputs[0].outputAction.Solution_you_re_interested_in__c));
        system.assertEquals(action.CustomResponse1__c, outputs[200].outputAction.Why_are_you_a_good_fit__c);
        system.assertEquals(action.CustomResponse2__c, outputs[200].outputAction.Which_position_are_you_interested_in__c);
        system.assertEquals(action.CustomResponse3__c, outputs[200].outputAction.Salary_Requirements__c);
        system.assertEquals(action.CustomResponse4__c, outputs[200].outputAction.LinkedIn_URL__c);
        system.assertEquals(0, outputs[200].outputErrors.size());
        
    }
    
    @IsTest
    static void testing_UNsuccessful_mapping(){
        CalendlyAction__c action = new CalendlyAction__c(
        	CustomQuestion1__c = 'Why are you a good fit? ',
            CustomResponse1__c = 'I work hard.',
            CustomQuestion2__c = 'Which position',
            CustomResponse2__c = 'SOS',
            CustomQuestion3__c = 'Salary requirements dgdhjsgjfds',
            CustomResponse3__c = '$1,000,000',
            CustomQuestion4__c = 'LinkedIn URL HELLO',
            CustomResponse4__c = 'linkedin.com'
        );
        
        calendly.InputParameters input = new calendly.InputParameters();
        input.inputAction = action;
        
        List<calendly.InputParameters> inputs = new List<calendly.InputParameters>();
        inputs.add(input);

        Test.startTest();
        	List<calendly.OutputParameters> outputs = calendly.mapping(inputs);
        Test.stopTest();
        
        system.assertEquals(TRUE, String.isBlank(outputs[0].outputAction.Budget__c));
        system.assertEquals(TRUE, String.isBlank(outputs[0].outputAction.Top_Challenges__c));
        system.assertEquals(TRUE, String.isBlank(outputs[0].outputAction.Company_Size__c));
        system.assertEquals(TRUE, String.isBlank(outputs[0].outputAction.Solution_you_re_interested_in__c));
        system.assertEquals(TRUE, String.isBlank(outputs[0].outputAction.Why_are_you_a_good_fit__c));
        system.assertEquals(TRUE, String.isBlank(outputs[0].outputAction.Which_position_are_you_interested_in__c));
        system.assertEquals(TRUE, String.isBlank(outputs[0].outputAction.Salary_Requirements__c));
        system.assertEquals(TRUE, String.isBlank(outputs[0].outputAction.LinkedIn_URL__c));
        system.assertEquals(4, outputs[0].outputErrors.size());
    }
}
