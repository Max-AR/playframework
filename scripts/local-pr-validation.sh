#!/usr/bin/env bash

# Copyright (C) 2009-2019 Lightbend Inc. <https://www.lightbend.com>

# shellcheck source=scripts/scriptLib
. "$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/scriptLib"

printMessage "RUNNING FRAMEWORK VALIDATION"
sbt headerCreate test:headerCreate javafmt test:javafmt scalafmtCheckAll scalafmtSbtCheck

pushd "$DOCUMENTATION"
printMessage "RUNNING DOCUMENTATION VALIDATION"
sbt headerCreate test:headerCreate javafmt test:javafmt scalafmtCheckAll scalafmtSbtCheck

git diff --exit-code . || (
  echo "WARN: Code changed after format and license headers validation. See diff above."
  echo "You need to commit the new changes or amend the existing commit. See more information"
  echo "about amending commits in our docs:"
  echo "https://playframework.com/documentation/latest/WorkingWithGit"
  false
)

popd

printMessage "ALL VALIDATIONS DONE"