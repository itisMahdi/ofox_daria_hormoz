/*
 * Copyright (C) 2026 The Android Open Source Project
 *
 * SPDX-License-Identifier: Apache-2.0
 */

#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <android-base/properties.h>

#define _REALLY_INCLUDE_SYS__SYSTEM_PROPERTIES_H_
#include <sys/_system_properties.h>

using android::base::GetProperty;
using std::string;

void property_override(string prop, string value)
{
    auto pi = (prop_info *)__system_property_find(prop.c_str());

    if (pi != nullptr)
        __system_property_update(pi, value.c_str(), value.size());
    else
        __system_property_add(prop.c_str(), prop.size(), value.c_str(), value.size());
}

void vendor_load_properties()
{
    string prop_partitions[] = {"", "vendor.", "odm.", "system.", "system_ext.", "product."};
    for (const string &prop : prop_partitions)
    {
        property_override(string("ro.product.") + prop + string("brand"), "Daria");
        property_override(string("ro.product.") + prop + string("manufacturer"), "Daria");
        property_override(string("ro.product.") + prop + string("name"), "hormoz");
        property_override(string("ro.product.") + prop + string("device"), "hormoz");
        property_override(string("ro.product.") + prop + string("model"), "DM-B70104");
        property_override(string("ro.product.") + prop + string("marketname"), "Daria Bond II");
    }
    property_override("ro.build.product", "hormoz");
    property_override("ro.board.platform", "mt6897");
}
