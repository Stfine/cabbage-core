package vc.thinker.pay.model;

import com.sinco.mybatis.dal.model.BaseModel;
import java.math.BigDecimal;

public class PayConfig extends BaseModel {
    /**  **/
    private Long id;

    /**  **/
    private BigDecimal alipayRate;

    /** 支付的应用私钥 **/
    private String appPrivateKey;

    /** 支付的支付宝公钥 **/
    private String appPublicKey;

    /**  **/
    private String content;

    /** 支付货币种类 **/
    private String currencyCode;

    /**  **/
    private Boolean install;

    /**  **/
    private String mark;

    /**  **/
    private String name;

    /**  **/
    private String partner;

    /** 支付手续费 **/
    private BigDecimal poundage;

    /**  **/
    private String safeKey;

    /**  **/
    private String sellerEmail;

    /**  **/
    private String tenpayKey;

    /** 微信商户号 **/
    private String tenpayPartner;

    /**  **/
    private Integer tradeMode;

    /** 微信支付AppSecret **/
    private String wxAppsecret;

    /** 微信支付appid **/
    private String wxAppid;

    /** 微信支付paySignKey **/
    private String wxPaysignkey;

    /**  **/
    private String payChannel;

    /**  **/
    private String signType;

    /** 支付宝应用ID **/
    private String alipayAppId;

    /** 支付宝开放平台的公钥，注意由于开放平台使用的私钥和支付是一个，配制应用公钥时需要和支付的公钥是一样的 **/
    private String alipayPublicKey;

    /** 微信证书位置 **/
    private String wxCertLocalPath;

    /** 微信RSA公钥 **/
    private String wxRsaPublic;

    /** stripe api key **/
    private String stripeApiKey;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public BigDecimal getAlipayRate() {
        return alipayRate;
    }

    public void setAlipayRate(BigDecimal alipayRate) {
        this.alipayRate = alipayRate;
    }

    public String getAppPrivateKey() {
        return appPrivateKey;
    }

    public void setAppPrivateKey(String appPrivateKey) {
        this.appPrivateKey = appPrivateKey;
    }

    public String getAppPublicKey() {
        return appPublicKey;
    }

    public void setAppPublicKey(String appPublicKey) {
        this.appPublicKey = appPublicKey;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getCurrencyCode() {
        return currencyCode;
    }

    public void setCurrencyCode(String currencyCode) {
        this.currencyCode = currencyCode;
    }

    public Boolean getInstall() {
        return install;
    }

    public void setInstall(Boolean install) {
        this.install = install;
    }

    public String getMark() {
        return mark;
    }

    public void setMark(String mark) {
        this.mark = mark;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPartner() {
        return partner;
    }

    public void setPartner(String partner) {
        this.partner = partner;
    }

    public BigDecimal getPoundage() {
        return poundage;
    }

    public void setPoundage(BigDecimal poundage) {
        this.poundage = poundage;
    }

    public String getSafeKey() {
        return safeKey;
    }

    public void setSafeKey(String safeKey) {
        this.safeKey = safeKey;
    }

    public String getSellerEmail() {
        return sellerEmail;
    }

    public void setSellerEmail(String sellerEmail) {
        this.sellerEmail = sellerEmail;
    }

    public String getTenpayKey() {
        return tenpayKey;
    }

    public void setTenpayKey(String tenpayKey) {
        this.tenpayKey = tenpayKey;
    }

    public String getTenpayPartner() {
        return tenpayPartner;
    }

    public void setTenpayPartner(String tenpayPartner) {
        this.tenpayPartner = tenpayPartner;
    }

    public Integer getTradeMode() {
        return tradeMode;
    }

    public void setTradeMode(Integer tradeMode) {
        this.tradeMode = tradeMode;
    }

    public String getWxAppsecret() {
        return wxAppsecret;
    }

    public void setWxAppsecret(String wxAppsecret) {
        this.wxAppsecret = wxAppsecret;
    }

    public String getWxAppid() {
        return wxAppid;
    }

    public void setWxAppid(String wxAppid) {
        this.wxAppid = wxAppid;
    }

    public String getWxPaysignkey() {
        return wxPaysignkey;
    }

    public void setWxPaysignkey(String wxPaysignkey) {
        this.wxPaysignkey = wxPaysignkey;
    }

    public String getPayChannel() {
        return payChannel;
    }

    public void setPayChannel(String payChannel) {
        this.payChannel = payChannel;
    }

    public String getSignType() {
        return signType;
    }

    public void setSignType(String signType) {
        this.signType = signType;
    }

    public String getAlipayAppId() {
        return alipayAppId;
    }

    public void setAlipayAppId(String alipayAppId) {
        this.alipayAppId = alipayAppId;
    }

    public String getAlipayPublicKey() {
        return alipayPublicKey;
    }

    public void setAlipayPublicKey(String alipayPublicKey) {
        this.alipayPublicKey = alipayPublicKey;
    }

    public String getWxCertLocalPath() {
        return wxCertLocalPath;
    }

    public void setWxCertLocalPath(String wxCertLocalPath) {
        this.wxCertLocalPath = wxCertLocalPath;
    }

    public String getWxRsaPublic() {
        return wxRsaPublic;
    }

    public void setWxRsaPublic(String wxRsaPublic) {
        this.wxRsaPublic = wxRsaPublic;
    }

    public String getStripeApiKey() {
        return stripeApiKey;
    }

    public void setStripeApiKey(String stripeApiKey) {
        this.stripeApiKey = stripeApiKey;
    }
}