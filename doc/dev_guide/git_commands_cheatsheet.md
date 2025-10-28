# Managing Branches

**Creating Branches**
``` bash
    git push -u origin <branch_name> # Push a branch and set its origin (for the intial push of a branch)
    git push --set-upstream origin <branch_name>
```

**Deleting Branches**

``` bash
    git fetch --all --prune # Gets all changes from remote and prunes dead branches
    git branch -d <branch_name> # Deletes a local branch
```