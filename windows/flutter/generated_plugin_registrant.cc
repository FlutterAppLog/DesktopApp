//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <realm/realm_plugin.h>
#include <url_launcher_windows/url_launcher_windows.h>
#include <window_to_front/window_to_front_plugin.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  RealmPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("RealmPlugin"));
  UrlLauncherWindowsRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("UrlLauncherWindows"));
  WindowToFrontPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("WindowToFrontPlugin"));
}
