#!/usr/bin/env stack
-- stack --install-ghc runghc --package turtle --package optparse-applicative

{-# LANGUAGE OverloadedStrings #-}

import Data.Text (Text, pack)
import Data.Text.IO (putStrLn, getLine)
import Turtle
import Prelude hiding (putStrLn, getLine)
import Options.Applicative
import System.Process

data VctlOptions
  = BuildCommand
  | ComponentCommand
  | InteractCommand
  | AboutCommand
  deriving (Show)

optionsParser :: Parser VctlOptions
optionsParser = subparser (
  command "build" (info
    (pure BuildCommand)
    (progDesc "Run a build step")
  )
  <> command "component" (info
     (pure ComponentCommand)
     (progDesc "Manage Vertex components")
  )
  <> command "interact" (info
     (pure InteractCommand)
     (progDesc "Start a Vertex shell")
  )
  <> command "about" (info
     (pure AboutCommand)
     (progDesc "Show information about this image")
  ))

main = do
  options <- execParser (info (optionsParser <**> helper)
    (fullDesc <> header "vctl - Vertex Control Utility"))

  case (options :: VctlOptions) of
    InteractCommand -> do
      printLogo
      putStrLn ""
      interactCommand
    AboutCommand -> aboutCommand

-------------------------------------------------------------------------------
-- Command Implementations
-------------------------------------------------------------------------------

aboutCommand = do
  printLogo
  printMany ["", "Showing versions of bundled utilities:", ""]
  showVersions
    [ ("NodeJS", "node", ["--version"])
    ]
  where
    showVersions :: [(Text, Text, [Text])] -> IO ()
    showVersions = mapM_ (\(name, cmd, args) -> do
      putStrLn $ "## " <> name <> " Version:"
      stdout (inproc cmd args empty))

interactCommand = do
  putStr "vctl> "

  choice <- getLine

  case choice of
    "hi" -> do
      putStrLn "Hello World"
      interactCommand
    "shell" -> do
      h <- runProcess "/bin/bash" [] Nothing Nothing Nothing Nothing Nothing
      waitForProcess h
      interactCommand
    "help" -> do
      putStrLn
        $ "Available commands: "
        <> pack (show ["hi", "shell", "help", "exit"])
      interactCommand
    "exit" -> return ()
    x -> do
      putStrLn "Invalid option. Try \"help\"."
      interactCommand

-------------------------------------------------------------------------------
-- Utilities
-------------------------------------------------------------------------------

printMany :: [Text] -> IO ()
printMany = mapM_ putStrLn

printLogo :: IO ()
printLogo = printMany
  [
    "| |  / / ____/ __ \\/_  __/ ____/ |/ /",
    "| | / / __/ / /_/ / / / / __/  |   /",
    "| |/ / /___/ _, _/ / / / /___ /   |",
    "|___/_____/_/ |_| /_/ /_____//_/|_|  v4.0"
  ]
