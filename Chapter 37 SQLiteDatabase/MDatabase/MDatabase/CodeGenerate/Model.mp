/*
{% table.name %}.m
{%Project%}
Created by {%Author%} on {%CreateDate%}.
Copyright (c) 2014 {%CopyRights%}. All rights reserved.
*/
#import "{%table.name%}.h"
@interface {%table.name%}()
@end

@implementation {%table.name%}
/*init property member var by parsing NSDictionary parameter*/
- (id)initWithDictionary:(NSDictionary *)dictionary{
	if ((self = [super init]) && (dictionary))
	{
        id value ;
{% foreach(field in table.fields) %}
        value = dictionary[@"{%field.name%}"];
{%if(field.isSimpleType==YES) %}
{%if(field.isBOOL==YES) %}
        if(value) _{%field.name%} = [value boolValue];
{% endif %}
{%if(field.isINTEGER==YES) %}
        if(value) _{%field.name%} = [value longValue];
{% endif %}
{%if(field.isDOUBLE==YES) %}
        if(value) _{%field.name%} = [value doubleValue];
{% endif %}
{% if (field.isFLOAT==YES) %}
        if(value) _{%field.name%} = [value floatValue];
{% endif %}
{%else %}
        if(value) _{%field.name%} = value;  
{% endif %}

{% endforeach %}  
    }
    return self;  
}               
- (id)initWithCoder:(NSCoder *)coder{
	if ((self = [super init]))
	{
    	if ([coder allowsKeyedCoding])
	    {
{% foreach(field in table.fields) %}
{%if(field.isSimpleType==YES) %}
{%if(field.isBOOL==YES) %}
            _{%field.name%} = [coder decodeBoolForKey:@"{%field.name%}"];
{%elseif(field.isINTEGER==YES) %}
            _{%field.name%} = [coder decodeIntegerForKey:@"{%field.name%}"];
{%elseif(field.isDOUBLE==YES) %}
            _{%field.name%} = [coder decodeDoubleForKey:@"{%field.name%}"];
{%else
            _{%field.name%} = [coder decodeFloatForKey:@"{%field.name%}"];               
{% endif %}
{%else %}
            _{%field.name%} = [coder decodeObjectForKey:@"{%field.name%}"];  
{% endif %}
{% endforeach %}
        }
        else
        {
{% foreach(field in table.fields) %}
{%if(field.isSimpleType==YES) %}
{%if(field.isBOOL==YES) %}
            _{%field.name%} = [[coder decodeObject]boolValue];
{%elseif(field.isINTEGER==YES) %}
            _{%field.name%} = [[coder decodeObject]longValue];
{%elseif(field.isDOUBLE==YES) %}
            _{%field.name%} = [[coder decodeObject]doubleValue];
{%else
            _{%field.name%} = [[coder decodeObject]floatValue];               
{% endif %}
{%else %}
            _{%field.name%} = [coder decodeObject];  
{% endif %}
{% endforeach %}        
        }
    }
    return self;
}
- (void)encodeWithCoder:(NSCoder *)coder {
	if ([coder allowsKeyedCoding])
	{
{% foreach(field in table.fields) %}
{%if(field.isSimpleType==YES)%}
{%if(field.isBOOL==YES) %}
        [coder encodeBool:_{%field.name%} forKey:@"{%field.name%}"];
{%elseif(field.isINTEGER==YES) %}
        [coder encodeInt64:_{%field.name%} forKey:@"{%field.name%}"];
{%elseif(field.isDOUBLE==YES) %}
        [coder encodeDouble:_{%field.name%} forKey:@"{%field.name%}"];
{%else
        [coder encodeFloat:_{%field.name%} forKey:@"{%field.name%}"];
{% endif%}
{%else%}
        if(_{%field.name%}) [coder encodeObject:_{%field.name%} forKey:@"{%field.name%}"];
{% endif %}
{% endforeach %}
    }
    else
    {
{% foreach(field in table.fields) %}
{%if(field.isSimpleType==YES)%}
{%if(field.isBOOL==YES) %}
        [coder encodeValueOfObjCType:@encode(BOOL) at:&_{%field.name%}];
{%elseif(field.isINTEGER==YES) %}
        [coder encodeValueOfObjCType:@encode(long) at:&_{%field.name%}];
{%elseif(field.isDOUBLE==YES) %}
        [coder encodeValueOfObjCType:@encode(double) at:&_{%field.name%}];
{%else
        [coder encodeValueOfObjCType:@encode(float) at:&_{%field.name%}];
{% endif%}
{%else%}
        if(_{%field.name%}) [coder encodeObject:_{%field.name%}];
{% endif %}
{% endforeach %}    
    }
}
- (BOOL)isEqual:({%table.name%} *)obj {
    if(![obj isKindOfClass:{%table.name%}.class])
    { 
        return NO;
    }
{% foreach(field in table.fields) %}
{%if(field.isSimpleType==YES) %}
{%if(fieldIndex==0)%}
    return (self.{%field.name%}==obj.{%field.name%})
{%else%}
    && (self.{%field.name%}==obj.{%field.name%})
{% endif %}
{%else%}
{%if(fieldIndex==0)%}
    return ([self.{%field.name%} isEqual:obj.{%field.name%}])
{%else%}
    && ([self.{%field.name%} isEqual:obj.{%field.name%}])
{% endif %}
{% endif %}
{%if(fieldIndex+1==table.fields.@count)%}
    ;
{% endif %}
{% endforeach %}
}

@end
