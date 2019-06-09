classdef unary_operator < matsim.library.block
    properties

    end
    
    methods
        function this = unary_operator(varargin)
            p = inputParser;
            p.CaseSensitive = false;
            % p.PartialMatching = false;
            p.KeepUnmatched = true;
            addOptional(p,'b1',{},@(x) isnumeric(x) || isempty(x) || isa(x,'matsim.library.block'));
            addParamValue(p,'ops','',@ischar);
            addParamValue(p,'parent','',@(x) ischar(x) || ishandle(x) || isa(x,'matsim.library.block') || isa(x,'matsim.library.simulation'));
            parse(p,varargin{:})
            
            inputs = {p.Results.b1};
            ops = p.Results.ops;
            parent = matsim.helpers.getValidParent(inputs{:},p.Results.parent);
            args = matsim.helpers.validateArgs(p.Unmatched);
            
            % validateattributes(parent,{'char'},{'nonempty'},'','parent')
            if isempty(parent)
                parent = gcs;
            end
            if isempty(ops)
                error('Invalid operator.')
            end
            
            this = this@matsim.library.block('type',ops,'parent',parent,args{:});
            if this.getUserData('created') == 0
                this.setInputs(inputs);
            end
        end
    end
end

