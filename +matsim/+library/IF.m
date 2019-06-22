classdef IF < matsim.library.block
%IF Creates a simulink If block.
% Syntax:
%   blk = IF(INPUTS);
%     INPUTS blocks will be connected to the block input ports.
%     INPUTS can be:
%       - an empty cell {}
%       - a matsim block
%       - a number
%       - a cell array of the above
%     If INPUTS is a number a Constant block with that value will
%     be created.
%   blk = IF(INPUTS, ARGS);
%     ARGS is an optional list of parameter/value pairs specifying simulink
%     block properties.
% 
% Example:
%   in1 = FromWorkspace('var1');
%   in2 = FromWorkspace('var2');
%   blk = IF({in1,in2});
% 
%   See also BLOCK.

    properties

    end
    
    methods
        function this = IF(varargin)
            p = inputParser;
            p.CaseSensitive = false;
            % p.PartialMatching = false;
            p.KeepUnmatched = true;
            addOptional(p,'inputs',{},@(x) isnumeric(x) || iscell(x) || isa(x,'matsim.library.block'));
            addParamValue(p,'parent','',@(x) ischar(x) || ishandle(x) || isa(x,'matsim.library.block') || isa(x,'matsim.library.simulation'));
            parse(p,varargin{:})
            
            inputs = p.Results.inputs;
            if ~iscell(inputs)
                inputs = {inputs};
            end
            
            parent = matsim.helpers.getValidParent(inputs{:},p.Results.parent);
            args = matsim.helpers.validateArgs(p.Unmatched);
            
            if isempty(parent)
                parent = gcs;
            end
            
            this = this@matsim.library.block('type','If','parent',parent,args{:});

            if this.getUserData('created') == 0
                this.set('NumInputs',mat2str(max(1,length(inputs))));
                this.set('IfExpression','u1>0');
                if length(inputs)>1
                    this.set('ElseIfExpressions',strjoin(arrayfun(@(i) sprintf('u%d>0',i),2:length(inputs),'uni',0),','));
                end
                this.setInputs(inputs);
            end
        end               
    end
end

