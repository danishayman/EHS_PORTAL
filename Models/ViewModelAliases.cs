using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

// This file creates aliases for view models from the CLIP area
namespace EHS_PORTAL
{
    // Account viewmodels
    public class LoginViewModel : EHS_PORTAL.Areas.CLIP.Models.LoginViewModel { }
    public class RegisterViewModel : EHS_PORTAL.Areas.CLIP.Models.RegisterViewModel { }
    public class ForgotPasswordViewModel : EHS_PORTAL.Areas.CLIP.Models.ForgotPasswordViewModel { }
    public class ResetPasswordViewModel : EHS_PORTAL.Areas.CLIP.Models.ResetPasswordViewModel { }
    public class ExternalLoginConfirmationViewModel : EHS_PORTAL.Areas.CLIP.Models.ExternalLoginConfirmationViewModel { }
    public class SendCodeViewModel : EHS_PORTAL.Areas.CLIP.Models.SendCodeViewModel { }
    public class VerifyCodeViewModel : EHS_PORTAL.Areas.CLIP.Models.VerifyCodeViewModel { }
    
    // Manage viewmodels
    public class ChangePasswordViewModel : EHS_PORTAL.Areas.CLIP.Models.ChangePasswordViewModel { }
    public class SetPasswordViewModel : EHS_PORTAL.Areas.CLIP.Models.SetPasswordViewModel { }
    public class AddPhoneNumberViewModel : EHS_PORTAL.Areas.CLIP.Models.AddPhoneNumberViewModel { }
    public class VerifyPhoneNumberViewModel : EHS_PORTAL.Areas.CLIP.Models.VerifyPhoneNumberViewModel { }
} 