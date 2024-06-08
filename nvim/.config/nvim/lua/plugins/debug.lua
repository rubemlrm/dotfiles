return {
    {
        "mfussenegger/nvim-dap"
    }, {
        "rcarriga/nvim-dap-ui",
        dependencies = {"mfussenegger/nvim-dap"},
        config = true
    }, {
        "leoluz/nvim-dap-go",
        dependencies = {"mfussenegger/nvim-dap"},
        build = "go install github.com/go-delve/delve/cmd/dlv@latest",
        config = true
    }, {
        "theHamsta/nvim-dap-virtual-text",
        dependencies = {"mfussenegger/nvim-dap"},
        config = true
    }
}
