package com.example.myfirstapp;

import android.content.Intent;
import android.os.Bundle;
import android.support.design.widget.NavigationView;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentTransaction;
import android.support.v4.view.GravityCompat;
import android.support.v4.widget.DrawerLayout;
import android.support.v7.app.ActionBarDrawerToggle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import com.example.myfirstapp.Fragments.*;
import com.example.myfirstapp.Menu.CreatorsActivity;
import com.example.myfirstapp.Menu.ProfileActivity;
import com.example.myfirstapp.Menu.ProfileCoActivity;
import com.example.myfirstapp.Menu.SettingActivity;


public class MainActivity extends AppCompatActivity
        implements NavigationView.OnNavigationItemSelectedListener,View.OnClickListener {

    Button button_gt;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Toolbar toolbar = findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        DrawerLayout drawer = findViewById(R.id.drawer_layout);
        NavigationView navigationView = findViewById(R.id.nav_view);
        ActionBarDrawerToggle toggle = new ActionBarDrawerToggle(
                this, drawer, toolbar, R.string.navigation_drawer_open, R.string.navigation_drawer_close);
        drawer.addDrawerListener(toggle);
        toggle.syncState();
        navigationView.setNavigationItemSelectedListener(this);
        button_gt = findViewById(R.id.button_gt);
        button_gt.setOnClickListener(this);


    }


    @Override
    public void onBackPressed() {
        DrawerLayout drawer = findViewById(R.id.drawer_layout);
        if (drawer.isDrawerOpen(GravityCompat.START)) {
            drawer.closeDrawer(GravityCompat.START);
        } else {
            super.onBackPressed();
        }
    }

    @SuppressWarnings("StatementWithEmptyBody")
    @Override
    public boolean onNavigationItemSelected(MenuItem item) {
        // Handle navigation view item clicks here.
        int id = item.getItemId();

        if (id == R.id.nav_co_list) {
            setTitle("Co-Working list");
            CowListFragment fragment = new CowListFragment();
            FragmentTransaction fragmentTransaction = getSupportFragmentManager().beginTransaction();
            fragmentTransaction.replace(R.id.fram, fragment, "FragmentCow");
            fragmentTransaction.addToBackStack("FragmentCow");
            fragmentTransaction.commit();


        } else if (id == R.id.nav_eql) {
            setTitle("Equipment list");
            CowListFragment fragment = new CowListFragment();
            FragmentTransaction fragmentTransaction = getSupportFragmentManager().beginTransaction();
            fragmentTransaction.replace(R.id.fram, fragment, "FragmentTwo");
            fragmentTransaction.addToBackStack("FragmentTwo");
            fragmentTransaction.commit();

        } else if (id == R.id.nav_map) {
            setTitle("Map");
            MapFragment fragment = new MapFragment();
            FragmentTransaction fragmentTransaction = getSupportFragmentManager().beginTransaction();
            fragmentTransaction.replace(R.id.fram, fragment, "Map");
            fragmentTransaction.addToBackStack("Map");
            fragmentTransaction.commit();

        } else if (id == R.id.nav_timeL) {
            setTitle("Timeline");
            TimeFragment fragment = new TimeFragment();
            FragmentTransaction fragmentTransaction = getSupportFragmentManager().beginTransaction();
            fragmentTransaction.replace(R.id.fram, fragment, "Timeline");
            fragmentTransaction.addToBackStack("Timeline");
            fragmentTransaction.commit();
        }

        DrawerLayout drawer = findViewById(R.id.drawer_layout);
        drawer.closeDrawer(GravityCompat.START);
        return true;

    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.button_gt:
                Intent intentbtn = new Intent(this, ProfileCoActivity.class);
                startActivity(intentbtn);
                overridePendingTransition(R.anim.slide_in_right, R.anim.slide_out_left);
                break;
            default:
                break;
        }

    }

}