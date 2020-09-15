
[1mFrom:[0m /mnt/c/Users/elyse/dev/flatiron/labs/tandem-app/app/controllers/permissions_controller.rb:21 PermissionsController#create:

    [1;34m10[0m: [32mdef[0m [1;34mcreate[0m
    [1;34m11[0m:   @user = [1;34;4mUser[0m.find_by([35memail[0m: params[[33m:permission[0m][[33m:user_email[0m])
    [1;34m12[0m:   [32mif[0m @user
    [1;34m13[0m:     @permission = [1;34;4mPermission[0m.new(permissions_params.except([31m[1;31m"[0m[31muser_email[1;31m"[0m[31m[0m))
    [1;34m14[0m:     @permission.user_id = @user.id
    [1;34m15[0m:     @permission.save
    [1;34m16[0m:     redirect_to project_permissions_path(params[[33m:project_id[0m])
    [1;34m17[0m:   [32melse[0m
    [1;34m18[0m:     @project = [1;34;4mProject[0m.find_by([35mid[0m: params[[33m:project_id[0m])
    [1;34m19[0m:     @collaborator_list = @project.collaborators_with_access_level
    [1;34m20[0m:     flash.now[[33m:error[0m] = [31m[1;31m"[0m[31mThis email address is not currently associated with a Tandem user.[1;31m"[0m[31m[0m
 => [1;34m21[0m:     binding.pry
    [1;34m22[0m:     render [33m:index[0m
    [1;34m23[0m:   [32mend[0m
    [1;34m24[0m: [32mend[0m

