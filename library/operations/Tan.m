classdef Tan < unary_operator
%TAN Creates a simulink Tan block.
% Example:
%   input = Constant('var1');
%   blk = Tan(input,'Name','myTan');
% 
%   See also UNARY_OPERATOR.

    properties
        
    end
    
    methods
        function this = Tan(varargin)
            p = inputParser;
            p.CaseSensitive = false;
            % p.PartialMatching = false;
            p.KeepUnmatched = true;
            addOptional(p,'b1',{},@(x) isnumeric(x) || isempty(x) || isa(x,'block'));
            parse(p,varargin{:})
          
            b1 = p.Results.b1;
            args = helpers.validateArgs(p.Unmatched);
            
            this = this@unary_operator(b1,'ops','Trigonometric Function','Operator','Tan',args{:});
        end
    end
    
end

