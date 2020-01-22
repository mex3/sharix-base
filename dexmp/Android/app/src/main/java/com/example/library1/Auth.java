package com.example.library1;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.content.SharedPreferences;
import android.graphics.Color;
import android.graphics.PorterDuff;
import android.net.Uri;
import android.os.Bundle;
import android.text.Editable;
import android.text.Spanned;
import android.text.TextWatcher;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.FrameLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.example.library1.data.Consts;

/**
 * @author DexMP (http://t.me/Dex_mp)
 * @version 1.0.2
 */
public class Auth extends AppCompatActivity {

    EditText login, password, name;
    Button singIn, registr, ok;
    TextView text_acc, rules;
    CheckBox checkRules;
    FrameLayout checkRules_host;
    boolean singer;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_auth);
        singer = false;
        final SharedPreferences inAccount = getSharedPreferences("in", MODE_PRIVATE);
        singer = inAccount.getBoolean("sing", false);
        if (singer){
            try {
                Log.d(Consts.TAG_LOG, "Авторизация пройдена успешно!");
                startActivity(new Intent(Auth.this, MainActivity.class));
                finish();
            } catch (Exception e){
                Log.d(Consts.TAG_LOG, "Падение при авторизации.");
                startActivity(new Intent(Auth.this, MainActivity.class));
                finish();
            }
        }
        initData();
        ui_sing();
        textHtml();
        checkAll();

        registr.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                ui_registration();
            }
        });

        singIn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (isCorrectEmail(login.getText().toString())) {
                    if (isStrongPassword(password.getText().toString())) {
                        SharedPreferences inAccount = getSharedPreferences("in", MODE_PRIVATE);
                        SharedPreferences.Editor editor = inAccount.edit();
                        editor.putBoolean("sing", true);
                        editor.apply();
                        startActivity(new Intent(Auth.this, MainActivity.class));
                        finish();
                    } else {
                        Toast.makeText(Auth.this, "Пароль не соответствует требованиям", Toast.LENGTH_SHORT).show();
                    }
                } else {
                    Toast.makeText(Auth.this, "Почта не соответствует требованиям", Toast.LENGTH_SHORT).show();
                }
            }
        });

        ok.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (isCorrectEmail(login.getText().toString())) {
                    if (isStrongPassword(password.getText().toString())) {
                        if (isCorrectName(name.getText().toString())) {
                            if (checkRules.isChecked()) {
                                SharedPreferences inAccount = getSharedPreferences("in", MODE_PRIVATE);
                                SharedPreferences.Editor editor = inAccount.edit();
                                editor.putBoolean("sing", true);
                                editor.apply();
                                startActivity(new Intent(Auth.this, MainActivity.class));
                                finish();
                            } else {
                                Toast.makeText(Auth.this, "Ознакомьтесь с правилами", Toast.LENGTH_SHORT).show();
                            }
                        } else {
                            Toast.makeText(Auth.this, "Введите имя", Toast.LENGTH_SHORT).show();
                        }
                    } else {
                        Toast.makeText(Auth.this, "Пароль не соответствует требованиям", Toast.LENGTH_SHORT).show();
                    }
                } else {
                    Toast.makeText(Auth.this, "Почта не соответствует требованиям", Toast.LENGTH_SHORT).show();
                }
            }
        });
    }

    public static boolean isStrongPassword(String value){
        if (value.length() < 6) return false;
        if (!value.matches(".*[0-9].*")) return false;
        if (!value.matches(".*[a-z].*")) return false;
        if (value.matches(".*[ ].*")) return false;

        return true;
    }

    public static boolean isCorrectName (String value){
        if (value.length() < 2) return false;
        if (!value.matches(".*[а-я].*")) return false;
        return true;
    }

    public static boolean isCorrectEmail(String value){
        if (value.length() < 8) return false;
        if (!value.contains("@")) return false;
        if (!value.contains(".")) return false;

        return true;
    }

    private void initData(){
        // EditText
        login = findViewById(R.id.login);
        password = findViewById(R.id.password);
        name = findViewById(R.id.name);
        // TextView
        text_acc =  findViewById(R.id.text_acc);
        rules =  findViewById(R.id.rules);
        // Button
        singIn = findViewById(R.id.singIn);
        registr = findViewById(R.id.registration);
        ok = findViewById(R.id.ok);
        // CheckBox
        checkRules = findViewById(R.id.checkRules);
        // FrameLayout
        checkRules_host = findViewById(R.id.checkRules_host);
    }

    private void ui_sing() {
        // visible
        login.setVisibility(View.VISIBLE);
        password.setVisibility(View.VISIBLE);
        singIn.setVisibility(View.VISIBLE);
        registr.setVisibility(View.VISIBLE);
        // gone
        text_acc.setVisibility(View.GONE);
        name.setVisibility(View.GONE);
        checkRules_host.setVisibility(View.GONE);
        rules.setVisibility(View.GONE);
        ok.setVisibility(View.GONE);
    }

    private void ui_registration() {
        // gone
        registr.setVisibility(View.GONE);
        singIn.setVisibility(View.GONE);
        // visible
        login.setVisibility(View.VISIBLE);
        password.setVisibility(View.VISIBLE);
        text_acc.setVisibility(View.VISIBLE);
        name.setVisibility(View.VISIBLE);
        checkRules_host.setVisibility(View.VISIBLE);
        rules.setVisibility(View.VISIBLE);
        ok.setVisibility(View.VISIBLE);
    }

    private void  textHtml() {
        String htmlTag1 = "<u>Уже есть аккаунт?</u>";
        Spanned span1 = android.text.Html.fromHtml(htmlTag1);
        text_acc.setText(span1);
        text_acc.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                ui_sing();
            }
        });

        String htmlTag2  = "<u>Правила сайта и приложения</u>";
        Spanned span2  =  android.text.Html.fromHtml(htmlTag2);
        rules.setText(span2);
        rules.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent browserIntent = new Intent(Intent.ACTION_VIEW, Uri.parse("https://drive.google.com/file/d/1b5Jot2C_cHZejrbHhS3J3VX2xgycUS_4/view"));
                startActivity(browserIntent);
            }
        });
    }

    private void checkAll() {
        login.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence charSequence, int i, int i1, int i2) {

            }

            @Override
            public void onTextChanged(CharSequence charSequence, int i, int i1, int i2) {

            }

            @Override
            public void afterTextChanged(Editable editable) {
                if (isCorrectEmail(login.getText().toString())){
                    login.getBackground().setColorFilter(Color.parseColor("#85b3c1"), PorterDuff.Mode.SRC_ATOP);
                } else {
                    login.getBackground().setColorFilter(Color.RED, PorterDuff.Mode.SRC_ATOP);
                }
            }
        });

        password.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence charSequence, int i, int i1, int i2) {

            }

            @Override
            public void onTextChanged(CharSequence charSequence, int i, int i1, int i2) {

            }

            @Override
            public void afterTextChanged(Editable editable) {
                if (isStrongPassword(password.getText().toString())) {
                    password.getBackground().setColorFilter(Color.parseColor("#85b3c1"), PorterDuff.Mode.SRC_ATOP);
                } else {
                    password.getBackground().setColorFilter(Color.RED, PorterDuff.Mode.SRC_ATOP);
                }
            }
        });

        name.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence charSequence, int i, int i1, int i2) {

            }

            @Override
            public void onTextChanged(CharSequence charSequence, int i, int i1, int i2) {

            }

            @Override
            public void afterTextChanged(Editable editable) {
                if (isCorrectName(name.getText().toString())) {
                    name.getBackground().setColorFilter(Color.parseColor("#85b3c1"), PorterDuff.Mode.SRC_ATOP);
                } else {
                    name.getBackground().setColorFilter(Color.RED, PorterDuff.Mode.SRC_ATOP);
                }
            }
        });
    }
}
