<div data-nodebb-header-content="navigation" id="elPrimaNav">
    <li class="d-flex justify-content-between align-items-center {navigation.class} dropend" id="user_label" title="[[global:login]]" role="menuitem">
        <a class="navigation-link align-items-center dropdown-toggle btn btn-sm btn-ghost" href="{relative_path}/login" aria-label="[[global:login]]">
            <span class="position-relative">
                <i class="fa fa-fw fa-sign-in {navigation.iconClass}"></i>
            </span>
            <span class="nav-text small visible-open fw-semibold">[[global:login]]</span>
        </a>
    </li>
    {{{ if allowRegistration }}}
    <li class="d-flex justify-content-between align-items-center {navigation.class} dropend" title="[[global:register]]" role="menuitem">
        <span class="text-xs visible-open">[[login:dont-have-account]]</span>
        <a class="navigation-link align-items-center dropdown-toggle btn btn-sm btn-ghost" href="{relative_path}/register" aria-label="[[global:register]]">
            <span class="position-relative">
                <i class="fa fa-fw fa-user-plus {navigation.iconClass}"></i>
            </span>
            <span class="nav-text small visible-open fw-semibold">[[global:register]]</span>
        </a>
    </li>
    {{{ end }}}
</div>