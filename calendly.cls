/**
* @Name:         calendly
* @Author:       Kicksaw, RM
* @Date:         2021-06-22
* @Description:  Maps the Calendly Actions custom questions / responses to their appropriate warehouse.
*/
global class calendly{
   /**
    * @Description  Maps the Calendly Actions custom questions / responses to their appropriate warehouse.
    * @Param        inputs - List<InputParameters>
    * @Return       List<OutputParameters>
    */
    @InvocableMethod(
    	label = 'Calendly Custom Field Mapping'
        description = 'Maps the Calendly Actions custom questions / responses to their appropriate warehouse.'
        category = 'Kicksaw'
    )
    global static List<OutputParameters> mapping(List<InputParameters> inputs){
    	//The base return record.
        CalendlyAction__c clonableAction = new CalendlyAction__c(); 
        
    	//Prepare the maps and populate the base return record with the default values.
        Map<String,Schema.SObjectField> apiToApiMap = Schema.CalendlyAction__c.getsObjectType().getDescribe().fields.getMap();
        Map<String,Schema.SObjectField> labelToApiMap = new Map<String,Schema.SObjectField>();
        for(String apiName : apiToApiMap.keySet()){
            SObjectField field = apiToApiMap.get(apiName);
            Schema.DisplayType fieldType = field.getDescribe().getType();
            if(fieldType==Schema.DisplayType.String||fieldType==Schema.DisplayType.TextArea){
                clonableAction.put(field,'');
            }
            labelToApiMap.put(field.getDescribe().getlabel(),field);
        }
        
        //Loop through the actions and map the custom questions / responses to their warehouse.
        List<OutputParameters> outputs = new List<OutputParameters>();
        for(InputParameters input : inputs){
            OutputParameters output = new OutputParameters();
            output.outputAction = clonableAction.clone();
            output.outputErrors = new List<String>();
            try{
                output.outputAction.put(labelToApiMap.get(input.inputAction.CustomQuestion1__c),input.inputAction.CustomResponse1__c);
            }catch(Exception e){
                output.outputErrors.add('Question / Response 1 Error: ' + e.getMessage());
            }
            try{
                output.outputAction.put(labelToApiMap.get(input.inputAction.CustomQuestion2__c),input.inputAction.CustomResponse2__c);
            }catch(Exception e){
                output.outputErrors.add('Question / Response 2 Error: ' + e.getMessage());
            }
            try{
                output.outputAction.put(labelToApiMap.get(input.inputAction.CustomQuestion3__c),input.inputAction.CustomResponse3__c);
            }catch(Exception e){
                output.outputErrors.add('Question / Response 3 Error: ' + e.getMessage());
            }
            try{
                output.outputAction.put(labelToApiMap.get(input.inputAction.CustomQuestion4__c),input.inputAction.CustomResponse4__c);
            }catch(Exception e){
                output.outputErrors.add('Question / Response 4 Error: ' + e.getMessage());
            }
            outputs.add(output);
        }
        
        //Return the actions.
        return outputs;
    }
    
    /**
     * @Description Wrapper class for input parameters
     */
    global class InputParameters {
        @InvocableVariable(label='Calendly Action')
        global CalendlyAction__c inputAction;
    }

    /**
     * @Description Wrapper class for output parameters
     */
    global class OutputParameters {
        @InvocableVariable(label='Calendly Action')
        global CalendlyAction__c outputAction;
        @InvocableVariable(label='Mapping Errors')
        global List<String> outputErrors;
    }
}
