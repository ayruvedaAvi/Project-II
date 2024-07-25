// const baseUrl = "https://labourlance-hosted.onrender.com/api/v1";
const baseUrl = "http://10.0.2.2:5000/api/v1";

//Auth urls
const loginUrl = "/auth/login";
const registerUrl = "/auth/register";
const logoutUrl = "/auth/logout";
const verifyOtpUrl = "/auth/verify";
const verifyEmailUrl = "/forgetPassword/verifyemail";
const verifyOtpForgotPassUrl = "/forgetPassword/verify";
const changePasswordUrl = "/forgetPassword/resetPassword";

//job urls
const postJobUrl = "/jobs";
const getAllJobsUrl = "/jobs";
const getJobByFilterUrl = "/jobs/search";
const getAllJobsByUserUrl = "/jobs/user";
const editJobUrl = "/jobs/edit";
const deleteJobUrl = "/jobs/delete";
const getSingleJobUrl = "/jobs/singlejob";

//notification
const storeFcmTokenUrl = "/notification/store-fcm-token";