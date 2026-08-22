function meander
    switch "$argv[1]"
        case --help -h help ''
            echo "meander - Fish-native directory navigation"
            echo
            echo "Bindings:"
            echo "  Alt+Up          parent, or previous child during a cycle"
            echo "  Alt+Down        next child"
            echo "  Alt+Shift+Down  FZF child picker"
            echo "  Alt+Left        Fish prevd"
            echo "  Alt+Right       Fish nextd"
            echo
            echo "Commands:"
            echo "  meander status"
            echo "  meander clear"
            echo "  meander favorite add [PATH]"
            echo "  meander favorite remove [PATH]"
            echo "  meander favorite list"
            echo "  meander favorite jump"
            echo "  meander root"
            echo "  meander config"
            echo "  meander doctor"
            return 0

        case status
            meander_status
        case clear
            meander_clear
        case favorite
            meander_favorite $argv[2..-1]
        case root
            meander_root
        case config
            meander_config
        case doctor
            meander_doctor
        case '*'
            echo "meander: unknown command '$argv[1]'"
            echo "Run 'meander --help' for usage."
            return 2
    end
end
