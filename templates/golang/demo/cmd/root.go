package cmd

import (
	"fmt"
	"os"

	"github.com/spf13/cobra"
)

var rootCmd = &cobra.Command{
	Use:   "whoami",
	Short: "A simple CLI tool to show system and user information",
	Long: `whoami is a CLI application that displays various information
about the current system and user. You can use different subcommands
to get specific information.`,
	Run: func(cmd *cobra.Command, args []string) {
		// 如果没有子命令，显示帮助信息
		cmd.Help()
	},
}

func Execute() {
	if err := rootCmd.Execute(); err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
}
