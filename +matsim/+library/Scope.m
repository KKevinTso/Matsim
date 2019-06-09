classdef Scope < matsim.library.block
    properties

    end
    
    methods
        function this = Scope(varargin)
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
            
            this = this@matsim.library.block('type','Scope','parent',parent,args{:});

            if this.getUserData('created') == 0
                if matsim.utils.getversion() >= 2015
                    scope_configuration = this.get('ScopeConfiguration');
                    scope_configuration.NumInputPorts = mat2str(length(inputs));
                    scope_configuration.LayoutDimensions = [length(inputs), 1]; % Rows, columns
                else
                    this.set('NumInputPorts',mat2str(length(inputs)));
                end

                this.setInputs(inputs);
            end
        end
        
        function [] = open(this)
            set_param(this.handle,'open','on');
        end
    end
end

