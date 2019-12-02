function menu = uimenu(parent, varargin)
    if isa(parent, 'matlab.graphics.Graphics') && (isempty(parent) || strcmp(parent.Tag, 'Clustergram'))
        menu = [];
    else
        menu = builtin('uimenu', parent, varargin{:});
    end
    if nargout == 0
        clear menu
    end
end