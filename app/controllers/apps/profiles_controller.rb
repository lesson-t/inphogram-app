class Apps::ProfilesController < ApplicationController
    def show
        @profile = current_user.profile
        @user = current_user
    end

    def edit
        @profile = current_user.profile || current_user.build_profile
    end

    def update
        @profile = current_user.profile || current_user.build_profile
        @profile.assign_attributes(profile_params)

        if @profile.save
            redirect_to profile_path, notice: 'プロフィールを更新'
        else
            flash.now[:error] = '更新できませんでした'
            render :edit
        end
    end

    def avatar_update
        @profile = current_user.profile
        if @profile.update(avatar: params[:profile][:avatar])
             flash[:success] = 'アバターが更新されました。'
            render json: { success: true, avatar_url: url_for(@profile.avatar) }, status: :ok
            # render json: { success: true }
          else
            flash[:error] = 'アバターの更新に失敗しました。再度お試しください。'
            render json: { success: false }, status: :unprocessable_entity
            # render json: { success: false }
          end
    end

    private
    def profile_params
        params.require(:profile).permit(
            :introduction,
            :gender,
            :birthday,
            :subscribed,
            :avatar
        )
    end
end